import QtQuick
import "root:/modules/common/"
import "../../"

Rectangle {
  id: root
  implicitHeight: Config.bar_height
  implicitWidth: Config.bar_height
  radius: Config.bar_height
  color: mouseArea.containsMouse ? Config.colors.primary : Config.colors.surface

  MaterialIcon {
    id: icon
    anchors.centerIn: parent
    icon: "volume_up"
    iconSize: 18
    fill: 1
    color: mouseArea.containsMouse ? Config.colors.text_dark : Config.colors.text
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true

    // onClicked:
  }
}
