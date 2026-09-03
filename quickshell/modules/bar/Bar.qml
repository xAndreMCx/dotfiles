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

    color: "transparent"
    implicitHeight: Config.bar_height
    WlrLayershell.namespace: "bar-" + root.modelData.name

    anchors {
      left: true
      right: true
      top: true
    }

    // Left Pill
    Item {
      anchors {
        left: parent.left
        top: parent.top
        bottom: parent.bottom
      }
      width: leftBar.implicitWidth + (Config.bar_height)

      Rectangle {
        color: "#{{colors.bg_main}}"
        bottomRightRadius: Config.bar_height / 2

        width: parent.width
        height: Config.bar_height
      }

      RowLayout {
        id: leftBar
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        spacing: 10
        ArchIcon {}
        Workspaces {
          target_screen: root.modelData
        }

      }

      RoundCorner {
        corner: RoundCorner.CornerEnum.TopLeft
        size: parent.height / 2
        color: "#{{colors.bg_main}}"

        anchors {
          left: parent.right
        }
      }

    }

    // Center Pill
    Item {
      anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        bottom: parent.bottom
      }
      width: middleBar.implicitWidth + (Config.bar_height * 2)

      Rectangle {
        color: "#{{colors.bg_main}}"
        bottomRightRadius: Config.bar_height / 2
        bottomLeftRadius: Config.bar_height / 2
        width: parent.width
        height: parent.height
      }

      RoundCorner {
        corner: RoundCorner.CornerEnum.TopRight
        size: parent.height / 2
        color: "#{{colors.bg_main}}"

        anchors {
          right: parent.left
        }
      }

      RowLayout {
        id: middleBar
        anchors.centerIn: parent
        spacing: 10

        WindowTitle {
          color: "#{{colors.fg_main}}"
        }
      }

      RoundCorner {
        corner: RoundCorner.CornerEnum.TopLeft
        size: parent.height / 2
        color: "#{{colors.bg_main}}"

        anchors {
          left: parent.right
        }
      }
    }

    // Right Pill
    Item {
      anchors {
        right: parent.right
        top: parent.top
        bottom: parent.bottom
      }
      width: rightBar.implicitWidth + (Config.bar_corner_radius * 2)

      RoundCorner {
        corner: RoundCorner.CornerEnum.TopRight
        size: parent.height / 2
        color: "#{{colors.bg_main}}"

        anchors {
          right: parent.left
        }
      }

      Rectangle {
        color: "#{{colors.bg_main}}"
        bottomLeftRadius: Config.bar_height / 2
        width: parent.width
        height: parent.height
      }

      RowLayout {
        id: rightBar
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        spacing: 10

        SysTray {}
        SysInfo {}
        DateTime {}
        PowerButton {}
      }
    }
  }

  // Top inner corners
  PanelWindow {
    screen: root.modelData
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    implicitHeight: Config.bar_corner_radius
    WlrLayershell.namespace: "bar_corners-" + root.modelData.name
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
}
