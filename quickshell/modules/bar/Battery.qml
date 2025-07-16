import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower

import "../../"
import "root:/modules/common"

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

  // function batIcon(percentage, charging) {
  //   const range = Math.floor(percentage * 10) * 10;
  //   const rangeStr = ("" + range).padStart(2, '0');
  //   let icon = `root:/icons/battery-${rangeStr}${charging ? "-charging" : ""}.svg`;
  //   return icon;
  // }

  function batIcon(percentage, charging) {
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

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true

    ToolTip.visible: containsMouse
    ToolTip.text: toolTipText()
    ToolTip.delay: 100
  }

  RowLayout {
    id: row
    spacing: 0

    MaterialIcon {
      text: root.batIcon(root.battery.percentage, root.battery.state == UPowerDeviceState.Charging)
      color: "{{colors.text_primary}}"
      iconSize: 18
    }
    // IconImage {
    //   id: icon
    //   Layout.preferredHeight: implicitSize
    //   Layout.preferredWidth: implicitSize
    //
    //   implicitSize: Config.bar_height
    //   source: root.batIcon(root.battery.percentage, root.battery.state == UPowerDeviceState.Charging)
    //
    //   MultiEffect {
    //     source: icon
    //     anchors.fill: icon
    //     colorization: 1
    //     colorizationColor: "{{colors.text_primary}}"
    //   }
    // }

    Text {
      text: `${Math.round(battery.percentage * 100)}%`
      color: Config.colors.text
      font.family: Config.font_family
      font.pixelSize: Config.font_size
    }
  }
}
