import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import "../../"

// TODO: maybe wrap this inside an Item (not sure about it yet)
Rectangle {
  id: root

  property int index
  property color workspace_color: Config.colors.primary
  property bool active: false

  Layout.preferredHeight: height
  Layout.preferredWidth: width
  color: (mouseArea.containsMouse || active) ? workspace_color : "transparent"
  height: Config.bar_height
  radius: Config.bar_height
  width: Config.bar_height

  Text {
    anchors.centerIn: parent
    color: (mouseArea.containsMouse || active) ? Config.colors.text_dark : Config.colors.text
    font.family: Config.font_family
    font.pixelSize: Config.font_size
    font.weight: mouseArea.containsMouse ? Font.Bold : Font.Normal
    text: index
  }

  MouseArea {
    id: mouseArea

    anchors.fill: parent
    hoverEnabled: true

    onClicked: Hyprland.dispatch(`workspace ${index}`)
  }
}
