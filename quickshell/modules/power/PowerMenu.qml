import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
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
      // WlrLayershell.namespace: "power_menu"
      color: "transparent"

      // focusable: true
      implicitHeight: root.focusedScreen?.height * root.menuSize
      implicitWidth: root.focusedScreen?.height * (grid.columns / grid.rows) * root.menuSize

      Rectangle {
        anchors.fill: parent
        radius: Config.rounding
        color: "{{colors.background_primary}}"
        border.width: 2
        border.color: "{{colors.red}}"

        GridLayout {
          id: grid
          anchors.centerIn: parent
          columns: 3
          rows: 2
          rowSpacing: 0
          columnSpacing: 0

          PowerButton {
            text: "Lock"
            icon: "lock"
            // command: "systemctl reboot"
            fill: 1

            Layout.alignment: Qt.AlignCenter
            implicitWidth: menu.width / grid.columns
            implicitHeight: menu.height / grid.rows
          }

          PowerButton {
            text: "Sleep"
            icon: "dark_mode"
            // command: "systemctl reboot"

            Layout.alignment: Qt.AlignCenter
            implicitWidth: menu.width / grid.columns
            implicitHeight: menu.height / grid.rows
          }

          PowerButton {
            text: "Logout"
            icon: "logout"
            // command: "systemctl reboot"

            Layout.alignment: Qt.AlignCenter
            implicitWidth: menu.width / grid.columns
            implicitHeight: menu.height / grid.rows
          }

          PowerButton {
            text: "BIOS"
            icon: "settings"
            command: "systemctl reboot --firmware-setup"
            fill: 1

            Layout.alignment: Qt.AlignCenter
            implicitWidth: menu.width / grid.columns
            implicitHeight: menu.height / grid.rows
          }

          PowerButton {
            text: "Reboot"
            icon: "restart_alt"
            command: "systemctl reboot"

            Layout.alignment: Qt.AlignCenter
            implicitWidth: menu.width / grid.columns
            implicitHeight: menu.height / grid.rows
          }

          PowerButton {
            text: "Shutdown"
            icon: "power_settings_new"
            command: "systemctl poweroff"

            Layout.alignment: Qt.AlignCenter
            implicitWidth: menu.width / grid.columns
            implicitHeight: menu.height / grid.rows
          }
        }
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
