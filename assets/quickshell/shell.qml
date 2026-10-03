//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1
//@ pragma DefaultEnv QS_ICON_THEME=Adwaita
//@ pragma IconTheme Adwaita

import QtQuick
import Quickshell

import "modules"
import "services"

ShellRoot {
  id: root

  // NotificationService { id: notificationService }

  // --- Core ---
  Background { id: background }
  Shortcuts { id: shortcuts }

  // --- Panels & UI ---
  TopBar { id: topBar }
  BottomMenu { id: bottomMenu }
  SettingsApp { id: settingsApp }
  LockScreen { id: lockScreen }
}