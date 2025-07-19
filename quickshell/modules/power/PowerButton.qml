import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs
import qs.modules.common

Item {
  id: root
  property string text
  property string icon
  property string command
  property int fill: 0

  readonly property var process: Process {
    command: ["sh", "-c", root.command]
  }

  Rectangle {
    radius: 15
    anchors.fill: parent
    color: mouseArea.containsMouse ? Config.colors.primary : "transparent"

    ColumnLayout {
      anchors.centerIn: parent
      MaterialIcon {
        icon: root.icon
        iconSize: 48
        Layout.alignment: Qt.AlignHCenter
        color: mouseArea.containsMouse ? Config.colors.text_dark : Config.colors.text
        fill: root.fill
      }
      Text {
        Layout.alignment: Qt.AlignHCenter
        text: root.text
        color: mouseArea.containsMouse ? Config.colors.text_dark : Config.colors.text
        font.family: Config.font_family
        font.pixelSize: Config.font_size
      }
    }
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true

    onClicked: process.startDetached()
  }
}
