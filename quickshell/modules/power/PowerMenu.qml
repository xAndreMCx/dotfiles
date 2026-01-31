import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland

import qs

Scope {
  id: root
  property var focusedScreen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name)
  property real menuSize: 0.5

  Loader {
    id: menuLoader
    active: false
    sourceComponent: PanelWindow {
      id: menu
      visible: menuLoader.active
      screen: root.focusedScreen

      anchors {
        left: true
        right: true
        top: true
        bottom: true
      }
      // color: "transparent"
      color: Qt.rgba(0, 0, 0, 0.4)
      WlrLayershell.namespace: "power_menu"

      // focusable: true

      Rectangle {
        id: menuBox
        anchors.centerIn: parent
        radius: Config.rounding
        color: "{{colors.background_primary}}"
        border.width: 2
        border.color: "{{colors.red}}"

        width: root.focusedScreen ? (root.focusedScreen.height * (grid.columns / grid.rows) * root.menuSize) : 0
        height: root.focusedScreen ? (root.focusedScreen.height * root.menuSize) : 0

        GridLayout {
          id: grid
          anchors.fill: parent

          columns: 3
          rows: 2
          rowSpacing: 0
          columnSpacing: 0

          PowerButton {
            text: "Lock"
            icon: "lock"
            command: "hyprlock"
            fill: 1

            Layout.alignment: Qt.AlignCenter
            implicitWidth: menuBox.width / grid.columns
            implicitHeight: menuBox.height / grid.rows
          }

          PowerButton {
            text: "Sleep"
            icon: "dark_mode"
            command: "systemctl suspend"

            Layout.alignment: Qt.AlignCenter
            implicitWidth: menuBox.width / grid.columns
            implicitHeight: menuBox.height / grid.rows
          }

          PowerButton {
            text: "Logout"
            icon: "logout"
            command: "hyprctl dispatch exit"

            Layout.alignment: Qt.AlignCenter
            implicitWidth: menuBox.width / grid.columns
            implicitHeight: menuBox.height / grid.rows
          }

          PowerButton {
            text: "BIOS"
            icon: "settings"
            command: "systemctl reboot --firmware-setup"
            fill: 1

            Layout.alignment: Qt.AlignCenter
            implicitWidth: menuBox.width / grid.columns
            implicitHeight: menuBox.height / grid.rows
          }

          PowerButton {
            text: "Reboot"
            icon: "restart_alt"
            command: "systemctl reboot"

            Layout.alignment: Qt.AlignCenter
            implicitWidth: menuBox.width / grid.columns
            implicitHeight: menuBox.height / grid.rows
          }

          PowerButton {
            text: "Shutdown"
            icon: "power_settings_new"
            command: "systemctl poweroff"

            Layout.alignment: Qt.AlignCenter
            implicitWidth: menuBox.width / grid.columns
            implicitHeight: menuBox.height / grid.rows
          }
        }
      }

      MouseArea {
        anchors.fill: parent
        z: -1 // behind buttons to allow button clicks

        onClicked: menuLoader.active = false
      }
    }
  }

  IpcHandler {
    target: "power_menu"

    function toggle(): void {
      menuLoader.active = !menuLoader.active;
    }
  }
}
