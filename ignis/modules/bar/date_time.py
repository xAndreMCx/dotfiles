import datetime as dt
from ignis.widgets import Widget


def update_datetime(self: Widget.Label) -> None:
    date = dt.datetime.now().strftime("%A, %d %b %Y")
    time = dt.datetime.now().strftime("%I:%M %p")
    self.label = f" {date} |  {time}"


def datetime() -> Widget.Label:
    return Widget.Label()
