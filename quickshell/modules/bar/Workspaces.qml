import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import qs

Item {
  id: root

  property var target_screen
  property int start_id: (target_screen && target_screen.name === "{{monitor_1}}") ? 1 : 11
  property int count: 10
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
        model: root.count

        Workspace {
          // modelData is index (0-9)
          index: modelData + root.start_id 
          display_label: (modelData + 1).toString()
          monitor_name: root.target_screen.name
          active: {
            if (!root.active_on_this_monitor) return false;
            return index == root.active_on_this_monitor.id;
          }
          contains_windows: {
            const ws = Hyprland.workspaces.values.find(w => w.id === index);
            return ws ? ws.windows > 0 : false;
          }
        }
      }
    }
  }
}
