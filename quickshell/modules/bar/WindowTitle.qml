import QtQuick
import Quickshell.Wayland

import qs

// TODO: add a background for the title and maybe make the titles less "noisy"

Text {
  readonly property int limit: 100
  property string title: ToplevelManager.activeToplevel?.activated ? ToplevelManager.activeToplevel?.title : "Desktop"
  text: title.length > limit ? title.substring(0, limit) + "..." : title
  font.family: Config.font_family
  font.pixelSize: Config.font_size - 2
}
