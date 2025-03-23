from ignis.widgets import Widget
from ignis.app import IgnisApp
import os

app = IgnisApp.get_default()


def power_button() -> Widget.Button:
    return Widget.Button(
        css_classes=["power_button"],
        child=Widget.Icon(image="power-symbolic"),
        on_click=lambda self: app.toggle_window("power_menu"),
    )


def restart_button() -> Widget.Box:
    return Widget.Box(
        css_classes=["power_menu_entry"],
        vertical=True,
        child=[
            Widget.Button(
                child=Widget.Icon(image="restart-symbolic"),
                on_click=lambda self: os.system("systemctl reboot"),
            ),
            Widget.Label(label="Restart"),
        ],
    )


def shutdown_button() -> Widget.Box:
    return Widget.Box(
        css_classes=["power_menu_entry"],
        vertical=True,
        child=[
            Widget.Button(
                child=Widget.Icon(image="power-symbolic"),
                on_click=lambda self: os.system("systemctl poweroff"),
            ),
            Widget.Label(label="Shutdown"),
        ],
    )


def lock_button() -> Widget.Box:
    return Widget.Box(
        css_classes=["power_menu_entry"],
        vertical=True,
        child=[
            Widget.Button(
                child=Widget.Icon(image="lock-symbolic"),
                on_click=lambda self: print("hi"),
            ),
            Widget.Label(label="Lock"),
        ],
    )


def power_menu() -> Widget.Window:
    menu = Widget.Window(
        namespace="power_menu",
        exclusivity="normal",
        layer="top",
        kb_mode="on_demand",
        popup=True,
        visible=False,
        child=Widget.Box(
            css_classes=["menu", "power_menu"],
            child=[lock_button(), restart_button(), shutdown_button()],
        ),
    )
    return menu
