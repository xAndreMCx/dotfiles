import datetime as dt
from ignis.widgets import Widget
from ignis.utils import Utils

def update_datetime(self: Widget.Label) -> None:
    date = dt.datetime.now().strftime("%A, %d %b %Y") 
    time = dt.datetime.now().strftime("%I:%M %p") 
    self.label = f" {date} |  {time}"

def datetime() -> Widget.Box:
    return Widget.Box(
        css_classes = ["center_box module"],
        child = [Widget.Label()]
    )


def bar(monitor: int) -> Widget.Window:
    date_time = datetime()
    Utils.Poll(1000, lambda x: update_datetime(date_time.child[0]))

    bar = Widget.Window(
        namespace = f"bar_monitor{monitor}",
        monitor = monitor,
        anchor = ["top", "left", "right"],
        exclusivity = "exclusive",
        layer = "top",
        margin_left = 10,
        margin_right = 10,
        margin_top = 3,
        child = Widget.CenterBox(
            css_classes = ["bar"],
            start_widget= Widget.Label(label = "Hello"),
            center_widget=date_time,
            end_widget=Widget.Label(label = "Hello")
        )
    ) 
    return bar

