import datetime as dt
from ignis.widgets import Widget
from ignis.utils import Utils
from ignis.services.hyprland import HyprlandService
from typing import Dict

from modules.power import power_button
from modules.volume import volume_button

hyprland = HyprlandService.get_default()


def update_datetime(self: Widget.Label) -> None:
    date = dt.datetime.now().strftime("%A, %d %b %Y")
    time = dt.datetime.now().strftime("%I:%M %p")
    self.label = f" {date} |  {time}"


def datetime() -> Widget.Label:
    return Widget.Label()


def workspace_dispatch(monitor: Dict[str, int], workspace_id: int):
    workspace = workspace_id + 10 * monitor["id"]
    hyprland.send_command(f"dispatch workspace {workspace}")


def workspaces(monitor: Dict[str, int]) -> Widget.Box:
    return Widget.Box(
        css_classes=["workspaces"],
        child=[
            Widget.Button(
                css_classes=["workspace_button", "bar_button"],
                child=Widget.Label(label=str(i)),
                on_click=lambda x: workspace_dispatch(monitor, int(x.child.label)),
            )
            for i in range(1, 11)
        ],
    )


def window_title() -> Widget.Label:
    return Widget.Label(
        hexpand=True,
        halign="center",
        css_classes=["window_title"],
        label="Hyprland",
    )


def update_window_title(self: Widget.Label, monitor: Dict[str, int]) -> None:
    active_monitor = hyprland.active_window.monitor
    if active_monitor == monitor["hyprland_id"]:
        self.label = hyprland.active_window.initial_title.title()


def left_box(monitor: Dict[str, int]) -> Widget.Box:
    arch_logo = Widget.Icon(css_classes=["arch_logo"], image="arch-symbolic")

    return Widget.Box(
        css_classes=["left_box", "module"],
        child=[arch_logo, workspaces(monitor)],
    )


def center_box(monitor: Dict[str, int]) -> Widget.Box:
    title = window_title()
    hyprland.connect(
        "notify::active-window",
        lambda x, y: update_window_title(title, monitor),
    )

    return Widget.Box(css_classes=["center_box", "module"], child=[title])


def right_box() -> Widget.Box:
    date_time = datetime()
    Utils.Poll(1000, lambda x: update_datetime(date_time))

    return Widget.Box(
        css_classes=["right_box", "module"],
        spacing=5,
        child=[
            volume_button(),
            date_time,
            power_button(),
        ],
    )


def bar(monitor: Dict[str, int]) -> Widget.Window:
    bar = Widget.Window(
        namespace=f"bar_monitor{monitor['id']}",
        monitor=monitor["hyprland_id"],
        anchor=["top", "left", "right"],
        exclusivity="exclusive",
        layer="top",
        child=Widget.CenterBox(
            css_classes=["bar"],
            start_widget=left_box(monitor),
            center_widget=center_box(monitor),
            end_widget=right_box(),
        ),
    )
    return bar
