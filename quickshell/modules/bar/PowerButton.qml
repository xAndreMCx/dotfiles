import QtQuick

import Quickshell.Io

import qs
import qs.modules.common

Rectangle {
  id: root
  implicitWidth: Config.bar_height
  implicitHeight: Config.bar_height
  color: mouseArea.containsMouse ? "#{{colors.red}}" : "transparent"
  radius: Config.bar_height

  MaterialIcon {
    anchors.centerIn: parent
    text: "power_settings_new"
    color: mouseArea.containsMouse ? "#{{colors.fg_inverse}}" : "#{{colors.red}}"
    font.weight: Font.DemiBold
    iconSize: 16
  }

  MouseArea {
    id: mouseArea

    anchors.fill: parent
    hoverEnabled: true

    Process {
      id: process
      command: ["qs", "ipc", "call", "power_menu", "toggle"]
    }

    onClicked: process.startDetached()
  }
}
