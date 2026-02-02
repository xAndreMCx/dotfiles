import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import qs

Scope {
  id: root
  property var focusedScreen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name)
  property real margins: 10

  Loader {
    id: menuLoader
    active: false
    sourceComponent: PanelWindow {
      id: menu
      visible: menuLoader.active
      // WlrLayershell.namespace: "network_menu"
      color: "transparent"
      anchors {
        top: true
        right: true
      }

      margins {
        top: root.margins
        right: root.margins
      }
      implicitHeight: 250
      implicitWidth: 400

      Rectangle {
        anchors.fill: parent
        radius: Config.rounding
        color: "#{{colors.bg_main}}"
        border.width: 2
        border.color: "#{{colors.primary}}"
      }
    }
  }

  IpcHandler {
    target: "bluetooth_menu"

    function toggle(): void {
      menuLoader.active = !menuLoader.active;
    }
  }
}
