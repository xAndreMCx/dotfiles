#!/usr/bin/env python3
"""
Toggle a uinput mouse click spammer (Wayland, no ydotool).
- First run -> start spamming
- Next run  -> stop it

Usage:
  toggle_clickspam.py [-v|--debug] [--log-file FILE] [clicks_per_sec] [button]
  button: 0=left (default), 1=right, 2=middle
"""

from __future__ import annotations
import os, sys, time, signal, subprocess, errno, argparse
from pathlib import Path


def pid_alive(pid: int) -> bool:
    try:
        os.kill(pid, 0)
        return True
    except OSError as e:
        return e.errno == errno.EPERM


def start_worker(rate: float, btn: int, pidfile: Path):
    exe = sys.executable
    script = os.path.realpath(__file__)
    cmd = [
        exe,
        script,
        "--worker",
        "--rate",
        str(rate),
        "--btn",
        str(btn),
        "--pidfile",
        str(pidfile),
    ]
    subprocess.Popen(
        cmd,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        start_new_session=True,
        close_fds=True,
    )


def stop_worker(pidfile: Path) -> bool:
    try:
        pid = int(pidfile.read_text().strip())
    except Exception as e:
        pidfile.unlink(missing_ok=True)
        return False

    try:
        os.kill(pid, signal.SIGTERM)
    except ProcessLookupError:
        pidfile.unlink(missing_ok=True)
        return False
    except PermissionError as e:
        return False

    # wait briefly, escalate if needed
    for _ in range(50):
        if not pid_alive(pid):
            pidfile.unlink(missing_ok=True)
            return True
        time.sleep(0.02)

    try:
        os.kill(pid, signal.SIGKILL)
    except ProcessLookupError:
        pass
    pidfile.unlink(missing_ok=True)
    return True


def worker(rate: float, btn: int, pidfile: Path):
    from evdev import UInput, ecodes as e

    BTN_CODES = [e.BTN_LEFT, e.BTN_RIGHT, e.BTN_MIDDLE]
    if btn < 0 or btn > 2:
        raise SystemExit(f"Invalid button {btn}; must be 0,1,2.")

    btn_code = BTN_CODES[btn]
    interval = 1.0 / rate

    # Build a realistic mouse device (fixes EINVAL on some kernels)
    capabilities = {
        e.EV_KEY: [e.BTN_LEFT, e.BTN_RIGHT, e.BTN_MIDDLE],
        e.EV_REL: [e.REL_X, e.REL_Y, e.REL_WHEEL, e.REL_HWHEEL],
    }

    try:
        ui = UInput(
            capabilities,
            name="clickspam-uinput",
            bustype=e.BUS_USB,
            vendor=0x1,
            product=0x1,
            version=1,
        )
    except OSError as ex:
        if isinstance(ex, OSError) and ex.errno == 13:
            print(
                "Hint: Permission denied on /dev/uinput. Add a udev rule and group, then re-login.",
                file=sys.stderr,
            )
        if isinstance(ex, OSError) and ex.errno == 22:
            print(
                "Hint: Invalid argument. Try ensuring EV_REL axes are present; kernel may reject key-only mice.",
                file=sys.stderr,
            )
        raise

    # write PID for the toggler
    try:
        pidfile.parent.mkdir(parents=True, exist_ok=True)
        pidfile.write_text(str(os.getpid()))
    except Exception as ex:
        print(f"Failed to write PID file {pidfile}: {ex}", file=sys.stderr)

    running = True

    def _stop(*_):
        nonlocal running
        running = False

    signal.signal(signal.SIGINT, _stop)
    signal.signal(signal.SIGTERM, _stop)

    while running:
        ui.write(e.EV_KEY, btn_code, 1)
        ui.syn()
        ui.write(e.EV_KEY, btn_code, 0)
        ui.syn()
        time.sleep(interval)

    pidfile.unlink(missing_ok=True)
    ui.close()


# ---------------- main ----------------
def main():
    parser = argparse.ArgumentParser(add_help=True)
    parser.add_argument(
        "rate",
        nargs="?",
        type=float,
        default=12.0,
        help="clicks per second (default 12)",
    )
    parser.add_argument(
        "button",
        nargs="?",
        type=int,
        default=0,
        help="0=left,1=right,2=middle (default 0)",
    )
    parser.add_argument(
        "-v", "--debug", action="store_true", help="enable debug prints"
    )
    parser.add_argument(
        "--log-file", help="append debug logs to this file (useful from keybinds)"
    )
    parser.add_argument("--pidfile", default=None, help="override PID file path")
    parser.add_argument("--worker", action="store_true", help=argparse.SUPPRESS)
    parser.add_argument("--rate", dest="rate_kw", type=float, help=argparse.SUPPRESS)
    parser.add_argument("--btn", dest="btn_kw", type=int, help=argparse.SUPPRESS)
    args = parser.parse_args()

    rate = args.rate_kw if args.rate_kw is not None else args.rate
    btn = args.btn_kw if args.btn_kw is not None else args.button

    runtime = Path(os.environ.get("XDG_RUNTIME_DIR") or f"/run/user/{os.getuid()}")
    pidfile = Path(args.pidfile) if args.pidfile else (runtime / "clickspam.pid")

    if args.worker:
        worker(rate, btn, pidfile)
        return

    # toggle mode
    if pidfile.exists():
        if stop_worker(pidfile):
            return

    start_worker(rate, btn, pidfile)


if __name__ == "__main__":
    main()
