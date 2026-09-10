//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
//@ pragma DefaultEnv QS_ICON_THEME=Adwaita

//@ pragma IconTheme Adwaita

import QtQuick
import Quickshell

import "./modules"
import "./services"

ShellRoot {
  id: root

  NotificationService { }

  // --- Core ---
  Background {
    id: myBackground
  }
  Shortcuts { }

  // --- Panels ---
  TopBar { }
  BottomMenu {
    onRequestWallpaperChange: (newUrl) => {
      myBackground.wallpaperPath = newUrl
    }
  }
  // SettingsApp { }
  LockScreen { }
}