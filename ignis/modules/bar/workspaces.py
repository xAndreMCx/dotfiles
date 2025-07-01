from ignis.widgets import Widget
from ignis.services.hyprland import HyprlandService
from typing import Dict

hyprland = HyprlandService.get_default()


def workspace_dispatch(monitor: Dict[str, int], workspace_id: int):
    workspace = workspace_id + 10 * monitor["id"]
    hyprland.send_command(f"dispatch workspace {workspace}")


def workspace_button(monitor: Dict[str, int], workspace_id: int):
    button = Widget.Button(
        css_classes=["workspace_button", "bar_button"],
        child=Widget.Label(label=str(workspace_id)),
        on_click=lambda x: workspace_dispatch(monitor, int(x.child.label)),
    )
    if int(button.child.label) == hyprland.active_workspace.id:
        button.add_css_class("workspace_btn_active")

    return button


def workspaces(monitor: Dict[str, int]) -> Widget.Box:
    return Widget.Box(
        css_classes=["workspaces"],
        child=hyprland.bind_many(
            ["workspaces", "active_workspace"],
            transform=lambda *_: [workspace_button(monitor, i) for i in range(1, 11)],
        ),
    )
