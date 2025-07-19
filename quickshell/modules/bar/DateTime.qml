import QtQuick
import QtQuick.Layouts

import qs
import qs.modules.common

Item {
  id: root
  implicitWidth: row.width
  implicitHeight: Config.bar_height

  RowLayout {
    id: row
    anchors.centerIn: parent
    spacing: 10

    RowLayout {
      spacing: 2
      MaterialIcon {
        icon: "calendar_today"
        fill: 1
        color: Config.colors.text
      }

      Text {
        color: Config.colors.text
        font.family: Config.font_family
        font.pixelSize: Config.font_size
        font.weight: Font.Bold
        text: Config.datetime.date
      }
    }

    RowLayout {
      spacing: 2
      MaterialIcon {
        icon: "schedule"
        color: Config.colors.text
      }

      Text {
        color: Config.colors.text
        font.family: Config.font_family
        font.pixelSize: Config.font_size
        font.weight: Font.Bold
        text: Config.datetime.time
      }
    }
  }
}
