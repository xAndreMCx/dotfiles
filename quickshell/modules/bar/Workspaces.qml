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
  implicitWidth: rowLayout.width + margin * 2

  Rectangle {
    anchors.fill: parent
    color: background_color
    radius: Config.bar_height

    RowLayout {
      id: rowLayout

      Layout.fillHeight: true
      spacing: 0
      x: margin

      Repeater {
        id: repeater

        model: 10

        Workspace {
          index: modelData + 1
          active: modelData + 1 == Hyprland.focusedWorkspace.id
        }
      }
    }
  }
}
