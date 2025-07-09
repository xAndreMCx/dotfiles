from ignis.widgets import Widget


def bluetooth_menu() -> Widget.Window:
    menu = Widget.Window(
        namespace="bluetooth_menu",
        layer="top",
        visible=False,
        child=Widget.Box(
            css_classes=["menu", "bluetooth_menu"], child=[Widget.Label(label="hello")]
        ),
    )
    return menu
