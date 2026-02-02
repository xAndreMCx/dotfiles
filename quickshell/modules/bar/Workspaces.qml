import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import qs

Item {
  id: root

  property var target_screen
  property int start_id: (target_screen && target_screen.name === "{{monitor_1}}") ? 1 : 11
  property int count: 10
  property color background_color: "#{{colors.bg_surface}}"
  property int margin: 5
  property color text_color: "#{{colors.fg_main}}"

  implicitHeight: Config.bar_height
  implicitWidth: rowLayout.width + 2 * margin

  Connections {
    target: Hyprland

    function onRawEvent(event) {
      const triggers = ["openwindow", "closewindow", "movewindow", "destroywindow"];
      if (triggers.includes(event.name)) {
        Hyprland.refreshWorkspaces();
      }
    }
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
            const monitor = Hyprland.monitorFor(target_screen)
            return monitor && monitor.activeWorkspace && monitor.activeWorkspace.id === index;
          }
          contains_windows: {
            const ws = Hyprland.workspaces.values.find(w => w.id === index);

            if (ws && ws.lastIpcObject && ws.lastIpcObject.windows !== undefined) {
              return ws.lastIpcObject.windows > 0;
            }
            return false;
          }
        }
      }
    }
  }
}
