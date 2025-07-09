from ignis.app import IgnisApp
from ignis import utils
from ignis.services.hyprland import HyprlandService

import json
from modules.bar.bar import bar_window
from modules.power import power_menu
from modules.volume import volume_menu
from modules.wifi import wifi_menu
from modules.bluetooth import bluetooth_menu

app = IgnisApp.get_default()
app.add_icons(f"{utils.get_current_dir()}/icons")
app.apply_css(f"{utils.get_current_dir()}/styles/style.scss")

hyprland = HyprlandService.get_default()
monitors_list = json.loads(hyprland.send_command("j/monitors"))
MONITORS = [
    {
        "hyprland_id": item["id"],
        "id": 0
        if item["name"] in ["DP-1", "eDP-1"]
        else 1,  # FIX: ids to allow for more monitors
        "name": item["name"],
    }
    for item in monitors_list
]

for n in range(len(monitors_list)):
    bar_window(MONITORS[n])

power_menu()
volume_menu()
wifi_menu()
bluetooth_menu()
