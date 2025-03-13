from ignis.widgets import Widget
from ignis.app import IgnisApp
from ignis.utils import Utils

from modules.bar.bar import bar

app = IgnisApp.get_default()
app.apply_css("./styles/style.scss")

for n in range(Utils.get_n_monitors()):
    bar(n)


