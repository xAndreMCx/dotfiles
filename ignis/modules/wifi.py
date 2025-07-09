from ignis.widgets import Widget
from ignis.services.network import NetworkService

network = NetworkService.get_default()

wifi = network.wifi
# print(wifi.devices[0].scan())


def wifi_menu_entry() -> Widget.Box:
    entry = Widget.Box()
    return entry


def wifi_menu() -> Widget.Window:
    menu = Widget.Window(
        namespace="wifi_menu",
        dynamic_input_region=True,
        anchor=["top", "right"],
        exclusivity="normal",
        popup=False,
        kb_mode="none",
        layer="top",
        margin_right=100,
        margin_top=2,
        visible=False,
        child=Widget.Box(
            vertical=True,
            css_classes=["menu", "wifi_menu"],
            child=[Widget.Label(label="hi")],
        ),
    )
    return menu
