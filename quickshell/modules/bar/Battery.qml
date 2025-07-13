import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell
import Quickshell.Services.UPower
import QtQuick.Effects

import "../../"

Item {
  id: root

  readonly property var battery: UPower.devices.values.filter(device => device.isLaptopBattery)[0]

  implicitHeight: Config.bar_height
  implicitWidth: row.width

  // function formatSecs(seconds) {
  //   let plural = x => {
  //     return x == 1 ? "" : "s";
  //   };
  //
  //   let hours = Math.floor(seconds / 3600);
  //   let minutes = Math.floor((seconds / 60) % 60);
  //   let result = [];
  //   if (hours != 0) {
  //     result.push(hours + " hour" + plural(hours));
  //   }
  //   if (minutes != 0) {
  //     result.push(minutes + " minute" + plural(minutes));
  //   }
  //   if (result.length == 0 || seconds % 60 != 0) {
  //     result.push(seconds % 60 + " second" + plural(seconds % 60));
  //   }
  //   return result.join(", ");
  // }
  //
  // function toolTipText() {
  //   console.log(battery.percentage);
  //   if (modelData.timeToFull != 0) {
  //     // Charging
  //     return `${formatSecs(modelData?.timeToFull)} until full`;
  //   } else if (modelData.timeToEmpty != 0) {
  //     // Discharging
  //     return `${formatSecs(modelData.timeToEmpty)} until empty`;
  //   } else if (modelData.percentage == 1) {
  //     return "Full";
  //   } else if (modelData.percentage == 0) {
  //     return "Empty";
  //   }
  //   return "Idle";
  // }

  function batIcon(percentage, charging) {
    const range = Math.floor(percentage * 10) * 10;
    const rangeStr = ("" + range).padStart(2, '0');
    let icon = `root:/icons/battery-${rangeStr}${charging ? "-charging" : ""}.svg`;
    return icon;
  }

  // MouseArea {
  //   anchors.fill: parent
  //   hoverEnabled: true
  //
  //   ToolTip.visible: containsMouse
  //   ToolTip.text: toolTipText()
  //   ToolTip.delay: 100
  // }

  RowLayout {
    id: row
    spacing: 3

    IconImage {
      id: icon
      Layout.preferredHeight: implicitSize
      Layout.preferredWidth: implicitSize

      implicitSize: Config.bar_height
      source: root.batIcon(root.battery.percentage, root.battery.state == UPowerDeviceState.Charging)
    }

    Label {
      text: `${Math.round(battery.percentage * 100)}%`
      color: Config.colors.text
      font.family: Config.font_family
      font.pixelSize: Config.font_size
      Layout.alignment: Qt.AlignCenter
    }
  }
}
