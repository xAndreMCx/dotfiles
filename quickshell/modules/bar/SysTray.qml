import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import Quickshell.Widgets

import qs
import qs.modules.bar

Item {
  id: root
  implicitHeight: Config.bar_height
  implicitWidth: layout.width

  RowLayout {
    id: layout
    anchors.verticalCenter: parent.verticalCenter
    spacing: 8

    Repeater {
      model: SystemTray.items

      delegate: MouseArea {
        id: trayItemRoot
        implicitWidth: Config.bar_height * 0.7
        implicitHeight: Config.bar_height * 0.7
        
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

        IconImage {
          anchors.fill: parent
          source: modelData.icon 
          opacity: trayItemRoot.containsMouse ? 1.0 : 0.8
        }

        onClicked: (mouse) => {
          if (mouse.button === Qt.LeftButton) {
            modelData.activate(); 
          } else if (mouse.button === Qt.MiddleButton) {
            modelData.secondaryActivate();
          } else if (mouse.button === Qt.RightButton) {
            if (modelData.menu) {
              // 1. Map the local (0,0) of the icon to the Window's coordinate space
              const windowPos = trayItemRoot.mapToItem(null, mouse.x, mouse.y);
              
              // 2. Pass the mapped coordinates to display()
              // Quickshell.window is the parentWindow requested by your docs
              modelData.display(bar, windowPos.x, windowPos.y);
            }
          }
        }

        // Standard scroll support
        onWheel: (wheel) => {
          modelData.scroll(wheel.angleDelta.y, false);
        }
      }
    }
  }
}
