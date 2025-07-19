pragma Singleton
import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property int bar_height: 22
  readonly property int rounding: 10
  readonly property QtObject colors: QtObject {
    property string base: "{{colors.surface}}"
    property string primary: "{{colors.accent_primary}}"
    property string surface: "{{colors.background_secondary}}"
    property string text: "{{colors.text_primary}}"
    property string text_dark: "{{colors.text_inverse}}"
  }
  readonly property QtObject datetime: QtObject {
    property string datetime: Qt.formatDateTime(clock.date, " dddd, dd MMM yyyy |  hh:mm AP")
    property string date: Qt.formatDateTime(clock.date, "dddd, dd MMM yyyy")
    property string time: Qt.formatDateTime(clock.date, "hh:mm AP")
  }
  readonly property string font_family: "JetBrains Mono Nerd Font"
  readonly property int font_size: 12
  readonly property int icon_size: 0.75 * bar_height

  SystemClock {
    id: clock

    precision: SystemClock.Minutes
  }
}
