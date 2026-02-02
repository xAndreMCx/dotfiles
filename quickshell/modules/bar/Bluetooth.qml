import QtQuick

import qs
import qs.modules.common

Rectangle {
  id: root
  implicitHeight: Config.bar_height
  implicitWidth: Config.bar_height
  radius: Config.bar_height
  color: mouseArea.containsMouse ? "#{{colors.primary}}" : "#{{colors.bg_surface}}"


  MaterialIcon {
    id: icon
    anchors.centerIn: parent
    icon: "bluetooth"
    color: mouseArea.containsMouse ? "#{{colors.fg_inverse}}" : "#{{colors.fg_main}}"

  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true

    // onClicked:
  }
}
