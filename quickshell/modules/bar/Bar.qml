import Quickshell
import QtQuick.Layouts
import QtQuick

import "../../"
import "../"

Scope {
  id: root

  PanelWindow {
    id: bar

    color: Config.colors.base
    implicitHeight: Config.bar_height

    anchors {
      left: true
      right: true
      top: true
    }

    RowLayout {
      id: row

      property int space: 5
      property int margin: 15

      width: parent.width
      height: parent.height

      RowLayout {
        id: leftBar
        // spacing: parent.space
        spacing: 5
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        Layout.leftMargin: parent.margin
        Layout.preferredWidth: Math.max(leftBar.implicitWidth, rightBar.implicitWidth)

        ArchIcon {}
        Workspaces {}
      }

      Item {
        Layout.fillWidth: true
      }

      RowLayout {
        id: middleBar
        Layout.alignment: Qt.AlignCenter
        spacing: parent.space

        WindowTitle {
          color: Config.colors.text
        }

        // media
      }

      Item {
        Layout.fillWidth: true
      }

      RowLayout {
        id: rightBar
        spacing: parent.space
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        Layout.rightMargin: parent.margin
        Layout.preferredWidth: Math.max(leftBar.implicitWidth, rightBar.implicitWidth)

        // system tray
        // battery
        Battery {}
        // wifi
        // bluetooth
        // volume


        PowerButton {}
      }
    }
  }

  PanelWindow {
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    implicitHeight: 15

    margins {
      top: Config.bar_height
    }

    anchors {
      left: true
      right: true
      top: true
    }

    RoundCorner {
      corner: RoundCorner.CornerEnum.TopLeft
      size: parent.height
      color: "{{colors.surface}}"

      anchors {
        left: parent.left
      }
    }

    RoundCorner {
      corner: RoundCorner.CornerEnum.TopRight
      size: parent.height
      color: "{{colors.surface}}"

      anchors {
        right: parent.right
      }
    }
  }

  PanelWindow {
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    implicitHeight: 15

    anchors {
      bottom: true
      left: true
      right: true
    }

    RoundCorner {
      corner: RoundCorner.CornerEnum.BottomLeft
      color: "{{colors.surface}}"
      size: parent.height

      anchors {
        left: parent.left
      }
    }

    RoundCorner {
      corner: RoundCorner.CornerEnum.BottomRight
      size: parent.height
      color: "{{colors.surface}}"

      anchors {
        right: parent.right
      }
    }
  }
}
