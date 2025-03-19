from ignis.app import IgnisApp
from ignis.app import Utils
from ignis.services.hyprland import HyprlandService
import json
from modules.bar.bar import bar

app = IgnisApp.get_default()
# app.apply_css("./styles/style.scss")

hyprland = HyprlandService.get_default()
# hyprland.connect("notify::active-workspace", lambda x, y: print(x, y))
monitors_list = json.loads(hyprland.send_command("j/monitors"))
MONITORS = [
    {
        "hyprland_id": item["id"],
        "id": 0 if item["name"] == "DP-1" else 1,
        "name": item["name"],
    }
    for item in monitors_list
]

# for n in range(Utils.get_n_monitors()):
for n in range(2):
    bar(MONITORS[n])
