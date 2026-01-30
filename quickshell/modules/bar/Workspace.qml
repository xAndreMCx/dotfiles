import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import qs

Rectangle {
  id: root

  property int index
  property string monitor_name
  property string display_label: index
  property color workspace_color: Config.colors.primary
  property bool active: false
  property bool contains_windows: false

  Layout.preferredHeight: height
  Layout.preferredWidth: width

  color: (mouseArea.containsMouse || active) ? workspace_color : "transparent"
  height: Config.bar_height
  radius: Config.bar_height
  width: Config.bar_height

  Text {
    anchors.centerIn: parent

    color: {
      if (mouseArea.containsMouse || active) return Config.colors.text_dark;
      if (root.containsWindows) return "#22FF11";
      return Config.colors.text;
    }

    font.family: Config.font_family
    font.pixelSize: Config.font_size
    font.weight: mouseArea.containsMouse ? Font.Bold : Font.Normal
    text: display_label
  }

  MouseArea {
    id: mouseArea

    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: Hyprland?.dispatch(`workspace ${index}`)
  }
}
