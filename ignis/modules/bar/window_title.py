from ignis.widgets import Widget
from ignis.services.hyprland import HyprlandService
from typing import Dict

hyprland = HyprlandService.get_default()


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
