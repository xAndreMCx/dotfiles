from ignis.widgets import Widget
from ignis import utils
from ignis.services.hyprland import HyprlandService
from typing import Dict

from modules.bar.date_time import datetime, update_datetime
from modules.bar.workspaces import workspaces
from modules.bar.window_title import window_title, update_window_title
from modules.bar.sys_info import sys_info
from modules.power import power_button

hyprland = HyprlandService.get_default()


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
    utils.Poll(1000, lambda x: update_datetime(date_time))

    return Widget.Box(
        css_classes=["right_box", "module"],
        spacing=10,
        child=[
            sys_info(),
            date_time,
            power_button(),
        ],
    )


def bar_window(monitor: Dict[str, int]) -> Widget.Window:
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
