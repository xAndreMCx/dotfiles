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
    id: button
    radius: 10
    anchors.centerIn: parent
    color: mouseArea.containsMouse ? "#{{colors.primary}}" : "transparent"
    width: 0.6 * root.width
    height: 0.6 * root.height

    Behavior on color {
      ColorAnimation {
        duration: 200;
        easing.type: Easing.OutCubic
      }
    }

    ColumnLayout {
      anchors.centerIn: parent
      MaterialIcon {
        icon: root.icon
        iconSize: 48
        Layout.alignment: Qt.AlignHCenter
        color: mouseArea.containsMouse ? "#{{colors.fg_inverse}}" : "#{{colors.fg_main}}"
        fill: root.fill

        Behavior on color {
          ColorAnimation {
            duration: 200;
            easing.type: Easing.OutCubic
          }
        }
      }
      Text {
        Layout.alignment: Qt.AlignHCenter
        text: root.text
        color: mouseArea.containsMouse ? "#{{colors.fg_inverse}}" : "#{{colors.fg_main}}"
        font.family: Config.font_family
        font.pixelSize: Config.font_size

        Behavior on color {
          ColorAnimation {
            duration: 200;
            easing.type: Easing.OutCubic
          }
        }
      }
    }
  }

  MouseArea {
    id: mouseArea
    anchors.fill: button
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: process.startDetached()
  }
}
