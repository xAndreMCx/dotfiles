#!/usr/bin/env python3
"""
Toggle a uinput mouse click spammer (Wayland, no ydotool).
- First run -> start spamming
- Next run  -> stop it

Usage:
  toggle_clickspam.py [-v|--debug] [--log-file FILE] [clicks_per_sec] [button]
  button: 0=left (default), 1=right, 2=middle
  You can also set CLICKSPAM_DEBUG=1 to enable debug prints.
"""
from __future__ import annotations
import os, sys, time, signal, subprocess, errno, argparse, traceback
from pathlib import Path
from typing import Optional

# ---------------- logging helpers ----------------
def _now():
    return time.strftime("%H:%M:%S")

class Logger:
    def __init__(self, debug: bool, log_file: Optional[str]):
        self.debug = debug or os.environ.get("CLICKSPAM_DEBUG") in ("1", "true", "yes")
        self.stream = sys.stderr
        self.file = None
        if log_file:
            try:
                self.file = open(log_file, "a", buffering=1)
            except Exception as e:
                print(f"[{_now()}] [clickspam] WARN: cannot open log file {log_file}: {e}", file=sys.stderr)

    def log(self, msg: str):
        if not self.debug:
            return
        line = f"[{_now()}] [clickspam] {msg}"
        print(line, file=self.stream, flush=True)
        if self.file:
            print(line, file=self.file, flush=True)

    def close(self):
        if self.file:
            self.file.close()

# ---------------- core toggle ----------------
def pid_alive(pid: int) -> bool:
    try:
        os.kill(pid, 0)
        return True
    except OSError as e:
        return e.errno == errno.EPERM

def start_worker(rate: float, btn: int, pidfile: Path, log: Logger):
    exe = sys.executable
    script = os.path.realpath(__file__)
    cmd = [exe, script, "--worker", "--rate", str(rate), "--btn", str(btn), "--pidfile", str(pidfile)]
    if log.debug:
        cmd += ["--debug"]
    if log.file:
        cmd += ["--log-file", log.file.name]
    log.log(f"Starting worker: {cmd}")
    subprocess.Popen(
        cmd,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL if not log.debug else None,  # show worker stderr only in debug
        start_new_session=True,
        close_fds=True,
    )
    log.log("Worker spawned (detached).")

def stop_worker(pidfile: Path, log: Logger) -> bool:
    try:
        pid = int(pidfile.read_text().strip())
        log.log(f"Found PID file {pidfile} with PID={pid}")
    except Exception as e:
        log.log(f"Could not read PID file ({e}); removing if present.")
        pidfile.unlink(missing_ok=True)
        return False

    try:
        os.kill(pid, signal.SIGTERM)
        log.log(f"Sent SIGTERM to PID {pid}")
    except ProcessLookupError:
        log.log("Process not found; removing stale PID file.")
        pidfile.unlink(missing_ok=True)
        return False
    except PermissionError as e:
        log.log(f"Permission error sending SIGTERM: {e}")
        return False

    # wait briefly, escalate if needed
    for _ in range(50):
        if not pid_alive(pid):
            log.log("Worker exited cleanly.")
            pidfile.unlink(missing_ok=True)
            return True
        time.sleep(0.02)

    log.log("Worker did not exit after SIGTERM; sending SIGKILL.")
    try:
        os.kill(pid, signal.SIGKILL)
    except ProcessLookupError:
        pass
    pidfile.unlink(missing_ok=True)
    return True

# ---------------- worker (click spammer) ----------------
def worker(rate: float, btn: int, pidfile: Path, log: Logger):
    try:
        from evdev import UInput, ecodes as e
    except Exception as ex:
        log.log("Failed to import evdev. Install with: pacman -S python-evdev")
        raise

    BTN_NAMES = ["left", "right", "middle"]
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
    log.log(f"Creating UInput device: rate={rate} cps, button={BTN_NAMES[btn]}, interval={interval:.6f}s")
    log.log(f"Capabilities: {capabilities}")

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
        log.log(f"UInput creation failed: {ex}")
        if isinstance(ex, OSError) and ex.errno == 13:
            log.log("Hint: Permission denied on /dev/uinput. Add a udev rule and group, then re-login.")
        if isinstance(ex, OSError) and ex.errno == 22:
            log.log("Hint: Invalid argument. Try ensuring EV_REL axes are present; kernel may reject key-only mice.")
        raise

    # write PID for the toggler
    try:
        pidfile.parent.mkdir(parents=True, exist_ok=True)
        pidfile.write_text(str(os.getpid()))
        log.log(f"Wrote PID file: {pidfile}")
    except Exception as ex:
        log.log(f"Failed to write PID file {pidfile}: {ex}")

    running = True
    def _stop(*_):
        nonlocal running
        log.log("Received stop signal; shutting down.")
        running = False

    signal.signal(signal.SIGINT, _stop)
    signal.signal(signal.SIGTERM, _stop)

    clicks = 0
    try:
        while running:
            ui.write(e.EV_KEY, btn_code, 1); ui.syn()
            ui.write(e.EV_KEY, btn_code, 0); ui.syn()
            clicks += 1
            if log.debug and clicks % max(1, int(rate)) == 0:
                log.log(f"Sent {clicks} clicks...")
            time.sleep(interval)
    except Exception as ex:
        log.log(f"Worker loop error: {ex}\n{traceback.format_exc()}")
        raise
    finally:
        try:
            pidfile.unlink(missing_ok=True)
            log.log("Removed PID file.")
        except Exception as ex:
            log.log(f"Failed to remove PID file: {ex}")
        try:
            ui.close()
            log.log("Closed UInput device.")
        except Exception as ex:
            log.log(f"Failed to close UInput: {ex}")

# ---------------- main ----------------
def main():
    parser = argparse.ArgumentParser(add_help=True)
    parser.add_argument("rate", nargs="?", type=float, default=12.0, help="clicks per second (default 12)")
    parser.add_argument("button", nargs="?", type=int, default=0, help="0=left,1=right,2=middle (default 0)")
    parser.add_argument("-v","--debug", action="store_true", help="enable debug prints")
    parser.add_argument("--log-file", help="append debug logs to this file (useful from keybinds)")
    parser.add_argument("--pidfile", default=None, help="override PID file path")
    parser.add_argument("--worker", action="store_true", help=argparse.SUPPRESS)
    parser.add_argument("--rate", dest="rate_kw", type=float, help=argparse.SUPPRESS)
    parser.add_argument("--btn", dest="btn_kw", type=int, help=argparse.SUPPRESS)
    args = parser.parse_args()

    rate = args.rate_kw if args.rate_kw is not None else args.rate
    btn  = args.btn_kw if args.btn_kw is not None else args.button

    runtime = Path(os.environ.get("XDG_RUNTIME_DIR") or f"/run/user/{os.getuid()}")
    pidfile = Path(args.pidfile) if args.pidfile else (runtime / "clickspam.pid")

    log = Logger(debug=args.debug, log_file=args.log_file)
    log.log(f"Args: rate={rate}, btn={btn}, pidfile={pidfile}")
    log.log(f"Runtime dir: {runtime}")

    try:
        if args.worker:
            worker(rate, btn, pidfile, log)
            log.close()
            return

        # toggle mode
        if pidfile.exists():
            log.log(f"PID file exists: {pidfile} -> attempting stop")
            if stop_worker(pidfile, log):
                log.log("Stopped existing worker.")
                log.close()
                return
            log.log("Stop failed or stale PID; starting fresh worker.")
        else:
            log.log("No PID file; starting worker.")

        start_worker(rate, btn, pidfile, log)
    finally:
        log.close()

if __name__ == "__main__":
    main()
