import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import Quickshell

import "../../"
import "root:/modules/common"

Rectangle {
  id: root
  implicitWidth: Config.bar_height
  implicitHeight: Config.bar_height
  color: mouseArea.containsMouse ? "{{colors.red}}" : "transparent"
  radius: Config.bar_height

  // Text {
  //   id: icon
  //   text: ""
  //   font.pixelSize: Config.font_size + 2
  //   font.family: "JetBrains Mono Nerd Font Propo"
  //   anchors.centerIn: parent
  //   color: mouseArea.containsMouse ? "{{colors.text_inverse}}" : "{{colors.red}}"
  // }

  MaterialIcon {
    anchors.centerIn: parent
    text: "power_settings_new"
    color: mouseArea.containsMouse ? "{{colors.text_inverse}}" : "{{colors.text_primary}}"
    font.weight: Font.DemiBold
    iconSize: 16
  }
  // IconImage {
  //   id: icon
  //   source: Quickshell.iconPath("system-shutdown-symbolic")
  //   implicitSize: Config.icon_size
  //   anchors.centerIn: parent
  // }
  //
  // MultiEffect {
  //   source: icon
  //   anchors.fill: icon
  //
  //   colorization: 0
  //   colorizationColor: mouseArea.containsMouse ? "{{colors.text_inverse}}" : "{{colors.red}}"
  //   // saturation: -1
  //   maskSource: IconImage {
  //     source: Quickshell.iconPath("system-shutdown-symbolic")
  //     implicitSize: Config.icon_size
  //   }
  //   maskEnabled: true
  // }

  MouseArea {
    id: mouseArea

    anchors.fill: parent
    hoverEnabled: true

    // onClicked:

  }
}
