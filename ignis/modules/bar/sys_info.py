import asyncio
from ignis.widgets import Widget
from ignis.app import IgnisApp
from ignis.services.upower import UPowerService
from ignis.services.system_tray import SystemTrayService, SystemTrayItem
from ignis.services.network import NetworkService

from modules.volume import volume_button

app = IgnisApp.get_default()
power_service = UPowerService().get_default().batteries[0]
system_tray = SystemTrayService.get_default()
network = NetworkService.get_default()


class TrayItem(Widget.Button):
    __gtype_name__ = "TrayItem"

    def __init__(self, item: SystemTrayItem):
        if item.menu:
            menu = item.menu.copy()
        else:
            menu = None

        super().__init__(
            child=Widget.Box(
                child=[
                    Widget.Icon(image=item.bind("icon"), pixel_size=24),
                    menu,
                ]
            ),
            tooltip_text=item.bind("tooltip"),
            on_click=lambda x: asyncio.create_task(item.activate_async()),
            setup=lambda self: item.connect("removed", lambda x: self.unparent()),
            on_right_click=lambda x: menu.popup() if menu else None,
            css_classes=["tray-item", "unset"],
        )


class Tray(Widget.Box):
    __gtype_name__ = "Tray"

    def __init__(self):
        super().__init__(
            css_classes=["tray"],
            setup=lambda self: system_tray.connect(
                "added", lambda x, item: self.append(TrayItem(item))
            ),
            spacing=10,
        )


def ram() -> Widget.Box:
    return Widget.Box(css_classes=[""], child=[Widget.Icon(), Widget.Label()])


def cpu() -> Widget.Box:
    return Widget.Box(css_classes=[""], child=[Widget.Icon(), Widget.Label()])


def battery() -> Widget.Box:
    return Widget.Box(
        css_classes=[""],
        spacing=2,
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
        child=Widget.Icon(image=network.wifi.bind("icon_name", lambda x: x)),
        on_click=lambda self: app.toggle_window("wifi_menu"),
    )


def bluetooth() -> Widget.Button:
    return Widget.Button(
        css_classes=["bluetooth_button", "bar_button"],
        child=Widget.Icon(image="bluetooth-symbolic"),
        on_click=lambda self: app.toggle_window("bluetooth_menu"),
    )


def sys_info() -> Widget.Box:
    return Widget.Box(
        css_classes=["sys_info"],
        spacing=5,
        child=[
            Tray(),
            # ram(),
            # cpu(),
            battery(),
            wifi(),
            bluetooth(),
            volume_button(),
        ],
    )
