from ignis.widgets import Widget
from ignis.app import IgnisApp
from ignis.services.audio import AudioService

app = IgnisApp.get_default()
audio = AudioService.get_default()
speaker = audio.speaker
mic = audio.microphone


def volume_button() -> Widget.Button:
    return Widget.Button(
        hexpand=True,
        halign="end",
        css_classes=["volume_button", "bar_button"],
        child=Widget.Icon(image=speaker.bind("icon_name")),
        # child=Widget.Icon(image=audio.streams[0].icon_name),
        on_click=lambda self: app.toggle_window("volume_menu"),
    )


def main_volume() -> Widget.Box:
    return Widget.Box(
        hexpand=True,
        css_classes=["volume_menu_entry"],
        child=[
            Widget.Button(
                child=Widget.Icon(image=speaker.bind("icon_name")),
                on_click=lambda x: speaker.set_is_muted(not speaker.is_muted),
            ),
            Widget.Scale(
                hexpand=True,
                value=speaker.bind_many(
                    ["volume", "is_muted"],
                    lambda volume, is_muted: 0
                    if is_muted or volume is None
                    else volume,
                ),
                min=0,
                max=200,
                on_change=lambda self: speaker.set_volume(self.value),
                step=1,
                vertical=False,
            ),
            Widget.Label(
                label=speaker.bind_many(
                    ["volume", "is_muted"],
                    lambda volume, is_muted: "0%"
                    if is_muted or volume is None
                    else f"{volume}%",
                )
            ),
        ],
    )


def main_mic() -> Widget.Box:
    return Widget.Box(
        hexpand=True,
        css_classes=["volume_menu_entry"],
        child=[
            Widget.Button(
                child=Widget.Icon(image=mic.bind("icon_name")),
                on_click=lambda x: mic.set_is_muted(not mic.is_muted),
            ),
            Widget.Scale(
                hexpand=True,
                value=mic.bind_many(
                    ["volume", "is_muted"],
                    lambda mic, is_muted: 0 if is_muted or mic is None else mic,
                ),
                min=0,
                max=100,
                on_change=lambda self: mic.set_volume(self.value),
                step=1,
                vertical=False,
            ),
            Widget.Label(
                label=mic.bind_many(
                    ["volume", "is_muted"],
                    lambda mic, is_muted: "0%"
                    if is_muted or mic is None
                    else f"{mic}%",
                )
            ),
        ],
    )


def volume_menu() -> Widget.Window:
    menu = Widget.Window(
        namespace="volume_menu",
        dynamic_input_region=True,
        anchor=["top", "right"],
        exclusivity="normal",
        layer="top",
        kb_mode="none",
        popup=False,
        visible=False,
        margin_right=100,
        margin_top=2,
        child=Widget.Box(
            css_classes=["menu", "volume_menu"],
            vertical=True,
            child=[main_volume(), main_mic()],
        ),
    )
    return menu
