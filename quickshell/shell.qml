//@ progma UseQApplication

import Quickshell

import qs.modules.bar
import qs.modules.power
import qs.modules.volume

// import qs.modules.network

Scope {
  Bar {}

  VolumeOSD {}

  // NetworkMenu {}
  VolumeMenu {}
  PowerMenu {}
}
