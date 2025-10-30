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
  property real margins: 10

  Loader {
    id: menuLoader
    active: false
    sourceComponent: PanelWindow {
      id: menu
      visible: menuLoader.active
      // WlrLayershell.namespace: "volume_menu"
      color: "transparent"
      anchors {
        top: true
        right: true
      }

      margins {
        top: root.margins
        right: root.margins
      }
      // focusable: true
      implicitHeight: 250
      implicitWidth: 400

      Rectangle {
        anchors.fill: parent
        radius: Config.rounding
        color: "{{colors.background_primary}}"
        border.width: 2
        border.color: Config.colors.primary

        ColumnLayout {
          id: column
          anchors {
            top: parent.top
            left: parent.left
            right: parent.right
          }
          spacing: 20

          ColumnLayout {
            spacing: 10

            VolumeEntry {
              id: mainVolume
              Layout.fillWidth: true
              Layout.topMargin: root.margins * 2
              margins: root.margins
            }

            VolumeEntry {
              id: mainMic
              Layout.fillWidth: true
              margins: root.margins
              icon: "mic"
            }
          }

          Rectangle {
            id: seperator
            Layout.alignment: Qt.AlignCenter
            implicitHeight: 2
            implicitWidth: parent.width * 0.8
            color: "{{colors.background_tertiary}}"
          }

          ColumnLayout {
            spacing: 10

            VolumeEntry {
              Layout.fillWidth: true
              margins: root.margins
            }

            VolumeEntry {
              Layout.fillWidth: true
              margins: root.margins
              icon: "mic"
            }

            // Item {
            //   Layout.fillHeight: true
            // }
          }
        }
      }
    }
  }

  IpcHandler {
    target: "volume_menu"

    function toggle(): void {
      menuLoader.active = !menuLoader.active;
    }
  }
}
