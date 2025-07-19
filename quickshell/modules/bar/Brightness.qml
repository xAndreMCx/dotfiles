import QtQuick
import "root:/modules/common/"
import "../../"

// TODO: add scroll to change brightness, maybe a revealer appears when clicked or a panel with a slider ( boring )

Rectangle {
  id: root
  implicitHeight: Config.bar_height
  implicitWidth: Config.bar_height
  radius: Config.bar_height
  color: mouseArea.containsMouse ? Config.colors.primary : Config.colors.surface

  MaterialIcon {
    id: icon
    anchors.centerIn: parent
    icon: "sunny"
    color: mouseArea.containsMouse ? Config.colors.text_dark : Config.colors.text
    fill: 1
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true

    // onClicked:
  }
}
