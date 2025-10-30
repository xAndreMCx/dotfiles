import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Wayland

import qs
import qs.modules.common

Scope {
  id: root
  property var sink: Pipewire.defaultAudioSink
  property var source: Pipewire.defaultAudioSource
  property bool showOsd: false

  PwObjectTracker {
    objects: [sink, source]
  }

  Connections {
    target: root.sink?.audio

    function onVolumeChanged() {
      root.showOsd = true;
      hideTimer.restart();
    }

    function onMutedChanged() {
      root.showOsd = true;
      hideTimer.restart();
    }
  }

  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: root.showOsd = false
  }

  LazyLoader {
    active: root.showOsd

    PanelWindow {
      visible: root.showOsd
      anchors.bottom: true
      margins.bottom: screen.height / 20

      implicitWidth: 400
      implicitHeight: 50
      color: "transparent"
      WlrLayershell.layer: WlrLayer.Overlay
      exclusionMode: ExclusionMode.Normal

      mask: Region {}

      Rectangle {
        anchors.fill: parent
        radius: height / 2
        // color: Config.colors.base.replace("#", "#80")
        color: Config.colors.base

        RowLayout {
          anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 15
          }

          MaterialIcon {
            icon: "volume_up"
            iconSize: 24
            fill: 1
            color: Config.colors.text
          }

          Rectangle {
            Layout.fillWidth: true

            implicitHeight: 10
            radius: 20
            color: Config.colors.surface

            Rectangle {
              anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
              }

              implicitWidth: parent.width * ((root.sink?.audio.volume ?? 0) / 1.5)
              radius: parent.radius
              color: Config.colors.primary
            }
          }

          Text {
            text: Math.round(root.sink?.audio.volume * 100) + "%"
            color: Config.colors.text
            Layout.preferredWidth: 30
            // Layout.alignment: Qt.AlignRight

            font.family: Config.font_family
            font.pixelSize: Config.font_size
          }
        }
      }
    }
  }
}
