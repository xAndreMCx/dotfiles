import QtQuick
import QtQuick.Layouts

import qs
import qs.modules.common

Item {
  id: root

  property string icon: "volume_up"
  property int iconSize: 18
  property int size: 25
  property real margins: 10

  implicitHeight: size

  RowLayout {
    id: row
    anchors.fill: parent
    spacing: root.margins

    Rectangle {
      Layout.leftMargin: root.margins
      Layout.alignment: Qt.AlignCenter
      implicitWidth: root.size
      implicitHeight: root.size
      radius: root.size
      color: iconArea.containsMouse ? Config.colors.primary : "transparent"
      MaterialIcon {
        icon: root.icon
        anchors.centerIn: parent
        color: iconArea.containsMouse ? Config.colors.text_dark : Config.colors.text
        fill: 1
        iconSize: root.iconSize
      }

      MouseArea {
        id: iconArea
        hoverEnabled: true
        anchors.fill: parent
      }
    }

    Rectangle {
      color: "{{colors.background_secondary}}"
      Layout.alignment: Qt.AlignCenter
      implicitHeight: root.size - 10
      Layout.fillWidth: true
      radius: root.size - 10

      Rectangle {
        anchors.left: parent.left
        color: Config.colors.primary
        implicitHeight: root.size - 10
        radius: root.size - 10
        implicitWidth: parent.width * 0.9
      }
    }

    Text {
      text: "90%"
      color: Config.colors.text
      font.family: Config.font_family
      font.pixelSize: Config.font_size
      Layout.rightMargin: root.margins
      Layout.alignment: Qt.AlignCenter
    }
  }
}
