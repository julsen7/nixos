//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1 

import QtQuick
import Quickshell

import "./components"
import "./services"
import "./modules/background"

ShellRoot {
  id: root

  // Players {}

  Background {}
  Shortcuts {}

  // DynamicIsland {}
}