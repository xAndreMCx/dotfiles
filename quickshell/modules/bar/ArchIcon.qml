import Quickshell.Widgets
import QtQuick
import "../../"

// TODO: make this a button that launches rofi
Rectangle {
  id: root
  implicitHeight: Config.bar_height
  implicitWidth: Config.bar_height
  color: "transparent"

  IconImage {
    anchors.centerIn: parent
    implicitSize: Config.icon_size
    source: "root:/icons/arch.svg"
  }
}
