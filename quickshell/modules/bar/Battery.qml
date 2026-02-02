import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower

import "../../"
import "root:/modules/common"

// TODO: add a window that allow for power profiles, show time till fully charged and time left

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
  //   if (battery.timeToFull != 0) {
  //     // Charging
  //     return `${formatSecs(battery?.timeToFull)} until full`;
  //   } else if (battery.timeToEmpty != 0) {
  //     // Discharging
  //     return `${formatSecs(battery.timeToEmpty)} until empty`;
  //   } else if (battery.percentage == 1) {
  //     return "Full";
  //   } else if (battery.percentage == 0) {
  //     return "Empty";
  //   }
  //   return "Idle";
  // }

  function battery_icon(percentage, charging) {
    percentage = percentage * 100;
    if (charging) {
      if (percentage <= 20) {
        return "battery_charging_20";
      } else if (percentage <= 30) {
        return "battery_charging_30";
      } else if (percentage <= 50) {
        return "battery_charging_50";
      } else if (percentage <= 60) {
        return "battery_charging_60";
      } else if (percentage <= 80) {
        return "battery_charging_80";
      } else if (percentage <= 90) {
        return "battery_charging_90";
      } else {
        return "battery_charging_full";
      }
    } else {
      if (percentage < 5) {
        return "battery_0_bar";
      } else if (percentage <= 15) {
        return "battery_1_bar";
      } else if (percentage <= 30) {
        return "battery_2_bar";
      } else if (percentage <= 45) {
        return "battery_3_bar";
      } else if (percentage <= 60) {
        return "battery_4_bar";
      } else if (percentage <= 75) {
        return "battery_5_bar";
      } else if (percentage <= 90) {
        return "battery_6_bar";
      } else {
        return "battery_full";
      }
    }
  }

  RowLayout {
    id: row
    spacing: 0

    MaterialIcon {
      // FullyCharged since it only occurs when plugged in and is 100% (never get 100% without being plugged in)
      icon: root.battery_icon(root.battery?.percentage, (root.battery?.state == UPowerDeviceState.Charging) || (root.battery?.state == UPowerDeviceState.FullyCharged))
      iconSize: 18
      color: "#{{colors.fg_main}}"
      fill: 1
    }

    Text {
      text: `${Math.round(root.battery?.percentage * 100)}%`
      color: "#{{colors.fg_main}}"
      font.family: Config.font_family
      font.pixelSize: Config.font_size
    }

    // MouseArea {
    //   anchors.fill: parent
    //   hoverEnabled: true
    //
    //   // ToolTip.visible: containsMouse
    //   // ToolTip.text: root.toolTipText()
    //   // ToolTip.delay: 100
    // }
  }
}
