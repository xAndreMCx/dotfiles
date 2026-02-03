import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

import qs
import qs.modules.common

Scope {
  id: root
  required property var modelData

  PanelWindow {
    id: bar
    screen: root.modelData

    color: "#{{colors.bg_main}}"
    implicitHeight: Config.bar_height
    WlrLayershell.namespace: "bar-" + root.modelData.name

    anchors {
      left: true
      right: true
      top: true
    }

    RowLayout {
      id: row

      property int space: 10
      property int margin: 10

      width: parent.width
      height: parent.height

      RowLayout {
        id: leftBar
        spacing: parent.space
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        Layout.leftMargin: parent.margin
        Layout.preferredWidth: Math.max(leftBar.width, rightBar.width)

        ArchIcon {}
        Workspaces {
          target_screen: root.modelData
        }
        Item {
          Layout.fillWidth: true
        }
      }

      RowLayout {
        id: middleBar
        Layout.alignment: Qt.AlignCenter
        spacing: parent.space

        WindowTitle {
          color: "#{{colors.fg_main}}"
        }

        // media
      }

      RowLayout {
        id: rightBar
        spacing: parent.space
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        Layout.rightMargin: parent.margin
        Layout.preferredWidth: Math.max(leftBar.width, rightBar.width)

        Item {
          Layout.fillWidth: true
        }
        SysTray {}

        SysInfo {}

        DateTime {}

        PowerButton {}
      }
    }
  }

  PanelWindow {
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    implicitHeight: 15
    WlrLayershell.namespace: "test"
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
      color: "#{{colors.bg_main}}"

      anchors {
        left: parent.left
      }
    }

    RoundCorner {
      corner: RoundCorner.CornerEnum.TopRight
      size: parent.height
      color: "#{{colors.bg_main}}"

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
      color: "#{{colors.bg_main}}"
      size: parent.height

      anchors {
        left: parent.left
      }
    }

    RoundCorner {
      corner: RoundCorner.CornerEnum.BottomRight
      size: parent.height
      color: "#{{colors.bg_main}}"

      anchors {
        right: parent.right
      }
    }
  }
}
