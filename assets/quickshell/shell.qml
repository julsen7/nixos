import QtQuick
import Quickshell
import Quickshell.Hyprland

import "./modules"

ShellRoot {
    id: root

    settings.watchFiles: true

    Binding {
        target: ShellState
        property: "shellRoot"
        value: root
    }

    Launcher {
        id: launcher
    }

    GlobalShortcut {
        name: "launcher"
        description: "Toggles app launcher"
        onPressed: launcher.toggle()
    }
}
