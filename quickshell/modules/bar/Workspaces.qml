import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import qs

Item {
  id: root

  property var target_screen
  property color background_color: Config.colors.surface
  property int margin: 5
  property color text_color: Config.colors.text

  implicitHeight: Config.bar_height
  implicitWidth: rowLayout.width + 2 * margin

  readonly property var active_on_this_monitor: {
    if (!target_screen) return null;
    const monitor = Hyprland.monitors.values.find(m => m.name === target_screen.name);
    return monitor ? monitor.activeWorkspace : null;
  }

  Rectangle {
    anchors.fill: parent
    color: background_color
    radius: Config.bar_height

    RowLayout {
      id: rowLayout
      anchors.centerIn: parent
      spacing: 0

      Repeater {
        id: repeater
        model: 10

        Workspace {
          // modelData is index (0-9)
          index: modelData + 1
          active: root.active_on_this_monitor && (index == root.active_on_this_monitor.id)
          containsWindows: {
            const ws = Hyprland.workspaces.get(index);
            return ws ? ws.windows > 0 : false;
          }
        }
      }
    }
  }
}
