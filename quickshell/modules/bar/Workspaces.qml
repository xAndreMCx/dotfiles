import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import "../../"

Item {
  id: root

  property color background_color: Config.colors.surface
  property int margin: 5
  property color text_color: Config.colors.text

  implicitHeight: Config.bar_height
  implicitWidth: rowLayout.width + 2 * margin

  Rectangle {
    anchors.fill: parent
    color: background_color
    radius: Config.bar_height

    RowLayout {
      id: rowLayout
      anchors.centerIn: parent

      spacing: 0

      Repeater {
        id: repeater

        model: 10

        Workspace {
          index: modelData + 1
          active: modelData + 1 == Hyprland?.focusedWorkspace?.id
        }
      }
    }
  }
}
