import QtQuick
import Quickshell
import Quickshell.Io

import "./modules"

ShellRoot {
    id: root

    Launcher {
        id: launcher
    }

    IpcHandler {
        target: "launcher"

        // Exponierte Funktion für den IPC-Aufruf
        function toggle(): void {
            launcher.toggle()
        }
    }
}