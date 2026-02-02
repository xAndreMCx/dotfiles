import QtQuick
import QtQuick.Layouts

import qs

Rectangle {
  id: root

  property int margin: 10
  implicitWidth: row.width + 2 * margin
  implicitHeight: Config.bar_height
  color: "#{{colors.bg_surface}}"
  radius: Config.bar_height

  RowLayout {
    id: row
    anchors.centerIn: parent
    spacing: 0

    Network {}
    Bluetooth {}
    Volume {}
    {%- if device == "laptop" %}
    Brightness {}
    Battery {}
    {%- endif %}
  }
}
