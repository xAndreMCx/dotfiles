import QtQuick
import QtQuick.Layouts

import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland

import qs

Scope {
  id: root
  property var focusedScreen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name)
  property real margins: 10
  property int size: 25

  Loader {
    id: menuLoader
    active: false
    sourceComponent: PanelWindow {
      id: menu
      visible: menuLoader.active
      WlrLayershell.namespace: "brightness_menu"
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
      implicitHeight: 60
      implicitWidth: 400

      Rectangle {
        anchors.fill: parent
        radius: Config.rounding
        color: "{{colors.background_primary}}"
        border.width: 2
        border.color: Config.colors.primary

        Slider {
          id: slider
          anchors.centerIn: parent
          from: 0
          value: 100
          to: 100
          stepSize: 1

          background: Rectangle {
            implicitHeight: root.size - 10
            implicitWidth: parent.width + handleRect.width
            radius: root.size - 10
            color: "{{colors.background_secondary}}"

            Rectangle {
              width: slider.visualPosition * slider.width
              height: parent.height
              color: Config.colors.primary
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
            color: Config.colors.text
          }
        }
      }
    }
  }

  IpcHandler {
    target: "brightness_menu"

    function toggle(): void {
      menuLoader.active = !menuLoader.active;
    }
  }
}
