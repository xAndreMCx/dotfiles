import QtQuick
import QtQuick.Layouts

import qs
import qs.modules.common
import QtQuick.Controls

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
      color: iconArea.containsMouse ? "#{{colors.primary}}" : "transparent"
      MaterialIcon {
        icon: root.icon
        anchors.centerIn: parent
        color: iconArea.containsMouse ? "#{{colors.fg_inverse}}" : "#{{colors.fg_main}}"
        fill: 1
        iconSize: root.iconSize
      }

      MouseArea {
        id: iconArea
        hoverEnabled: true
        anchors.fill: parent
      }
    }

    Slider {
      id: slider
      from: 0
      value: 100
      to: 150
      stepSize: 1
      Layout.alignment: Qt.AlignCenter
      Layout.preferredWidth: 280

      background: Rectangle {
        implicitHeight: root.size - 10
        implicitWidth: parent.width + handleRect.width
        radius: root.size - 10
        color: "#{{colors.bg_panel}}"

        Rectangle {
          width: slider.visualPosition * slider.width
          height: parent.height
          color: "#{{colors.primary}}"
          // radius: root.size - 10
          topLeftRadius: root.size - 10
          bottomLeftRadius: root.size - 10
        }
      }

      handle: Rectangle {
        id: handleRect
        x: slider.visualPosition * parent.width - (handleRect.width / 2)
        implicitWidth: root.size - 10
        implicitHeight: root.size - 10
        radius: root.size - 10
        color: "#{{colors.fg_main}}"
      }
    }

    Text {
      text: slider.value + '%'
      color: "#{{colors.fg_main}}"
      font.family: Config.font_family
      font.pixelSize: Config.font_size
      Layout.rightMargin: root.margins
      Layout.alignment: Qt.AlignCenter
      Layout.preferredWidth: 30
    }
  }
}
