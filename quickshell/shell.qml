//@ pragma UseQApplication

import Quickshell
import QtQuick

import qs.modules.bar
import qs.modules.power
import qs.modules.volume
import qs.modules.brightness

// import qs.modules.network

Scope {
  Variants {
    model: Quickshell.screens;

    delegate: Bar {}
  }

  VolumeOSD {}

  // NetworkMenu {}
  VolumeMenu {}
  BrightnessMenu {}
  PowerMenu {}
}
