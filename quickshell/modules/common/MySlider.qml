import QtQuick

import QtQuick.Layouts

import qs

Item {
  id: root
  property int size: 25

  Layout.alignment: Qt.AlignCenter
  Layout.fillWidth: true
  implicitHeight: root.size - 10

  Rectangle {
    color: "#{{colors.bg_surface}}"
    radius: root.size - 10
    anchors.fill: parent

    Rectangle {
      anchors.left: parent.left
      color: "#{{colors.primary}}"
      implicitHeight: root.size - 10
      radius: root.size - 10
      implicitWidth: parent.width * 0.9
    }

    MouseArea {
      id: sliderArea
      hoverEnabled: true
      anchors.fill: parent
    }
  }
}
