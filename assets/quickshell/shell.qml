//@ pragma DefaultEnv QSG_RENDER_LOOP=threaded
//@ pragma DefaultEnv QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

import QtQuick
import Quickshell
import Quickshell.Wayland

import "./modules"
import "./modules/background"

ShellRoot {
    id: root

    setting.watchFiles: true

    Binding {
        target: ShellState
        property: "shellRoot"
        value: root
    }
    
    // Services and Backend-Loader
    GSFLoader {}
    ServiceLoader {}

    // UI
    Background {}
    Drawers {}
    AreaPicker {}
    Lock { id: lock }

    // Global functionality
    ConfigToasts {}
    Shortcuts {}
    BatteryMonitor {}
    IdleMonitors { lock: lock }
}