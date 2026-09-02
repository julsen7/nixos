//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
//@ pragma DefaultEnv QS_ICON_THEME=Adwaita

//@ pragma IconTheme Adwaita

import QtQuick
import Quickshell

import "./components"
import "./services"
import "./modules"

ShellRoot {
  id: root

  // --- Services ---


  // --- Core ---
  Background {
    wallpaperPath: "file:///home/julsen/wallpaper/AssassinsCreedOrigins.jpg"
  }
  Shortcuts { }

  // --- Panels ---
  TopBar { }
  Menu { }
  // WallpaperSelector { }
  // LockScreen { }
}