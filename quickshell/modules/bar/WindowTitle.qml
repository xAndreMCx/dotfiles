import QtQuick
import Quickshell.Wayland

import "../../"

// TODO: add a background for the title and maybe make the titles less "noisy"

Text {
  text: ToplevelManager.activeToplevel?.activated ? ToplevelManager.activeToplevel?.title : "Desktop"
  font.family: Config.font_family
  font.pixelSize: Config.font_size - 2
}
