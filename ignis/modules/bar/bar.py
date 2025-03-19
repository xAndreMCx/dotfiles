import datetime as dt
from ignis.widgets import Widget
from ignis.utils import Utils
from ignis.services.hyprland import HyprlandService
import os
from typing import Dict

hyprland = HyprlandService.get_default()


def update_datetime(self: Widget.Label) -> None:
    date = dt.datetime.now().strftime("%A, %d %b %Y")
    time = dt.datetime.now().strftime("%I:%M %p")
    self.label = f" {date} |  {time}"


def datetime() -> Widget.Box:
    return Widget.Box(css_classes=["center_box module"], child=[Widget.Label()])


def workspace_dispatch(monitor: Dict[str, int], workspace_id: int):
    workspace = workspace_id + 10 * monitor["id"]
    # os.system(
    #     f"notify-send {monitor['name']},hypr={monitor['hyprland_id']}, id={monitor['id']}{workspace=}"
    # )
    hyprland.send_command(f"dispatch workspace {workspace}")


def workspaces(monitor: Dict[str, int]) -> Widget.Box:
    return Widget.Box(
        css_classes=["workspaces"],
        child=[
            Widget.Button(
                css_classes=["workspace_btn"],
                child=Widget.Label(label=str(i)),
                on_click=lambda x: workspace_dispatch(monitor, int(x.child.label)),
            )
            for i in range(1, 11)
        ],
    )


def window_title() -> Widget.Box:
    return Widget.Box(
        css_classes=["title"],
        child=[Widget.Label()],
    )


def update_window_title(self: Widget.Label, monitor: Dict[str, int]) -> None:
    active_monitor = hyprland.active_window["monitor"]
    if active_monitor == monitor["hyprland_id"]:
        self.label = hyprland.active_window["initialTitle"].title()


def left_box(monitor: Dict[str, int]) -> Widget.Box:
    title = window_title()
    hyprland.connect(
        "notify::active-window",
        lambda x, y: update_window_title(title.child[0], monitor),
    )

    return Widget.Box(css_classes=["left_box"], child=[workspaces(monitor), title])


def bar(monitor: Dict[str, int]) -> Widget.Window:
    date_time = datetime()
    Utils.Poll(1000, lambda x: update_datetime(date_time.child[0]))

    bar = Widget.Window(
        namespace=f"bar_monitor{monitor}",
        monitor=monitor["hyprland_id"],
        anchor=["top", "left", "right"],
        exclusivity="exclusive",
        layer="top",
        margin_left=10,
        margin_right=10,
        margin_top=3,
        child=Widget.CenterBox(
            css_classes=["bar"],
            start_widget=left_box(monitor),
            center_widget=date_time,
            end_widget=Widget.Label(label="Hello"),
        ),
    )
    return bar
