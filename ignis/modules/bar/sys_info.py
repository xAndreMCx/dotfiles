from ignis.widgets import Widget
from ignis.app import IgnisApp
from ignis.services.upower import UPowerService

from modules.volume import volume_button

app = IgnisApp.get_default()
power_service = UPowerService().get_default().batteries[0]


def ram() -> Widget.Box:
    return Widget.Box(css_classes=[""], child=[Widget.Icon(), Widget.Label()])


def cpu() -> Widget.Box:
    return Widget.Box(css_classes=[""], child=[Widget.Icon(), Widget.Label()])


def battery() -> Widget.Box:
    return Widget.Box(
        css_classes=[""],
        spacing=5,
        child=[
            Widget.Icon(image="battery_full-symbolic"),
            Widget.Label(
                label=power_service.bind("percent", lambda x: str(int(x)) + "%")
            ),
        ],
    )


def wifi() -> Widget.Button:
    return Widget.Button(
        css_classes=["wifi_button", "bar_button"],
        child=Widget.Icon(image="wifi-symbolic"),
        on_click=lambda self: app.toggle_window(),
    )


def bluetooth() -> Widget.Button:
    return Widget.Button(
        css_classes=["bluetooth_button", "bar_button"],
        child=Widget.Icon(image="bluetooth-symbolic"),
        on_click=lambda self: app.toggle_window(),
    )


def sys_info() -> Widget.Box:
    return Widget.Box(
        css_classes=[""],
        spacing=10,
        child=[
            ram(),
            cpu(),
            battery(),
            wifi(),
            bluetooth(),
            volume_button(),
        ],
    )
