import QtQuick
import Quickshell
import Quickshell.Io

import "./modules"

ShellRoot {
    id: root

    Launcher {
        id: launcher
    }

    // Ermöglicht das Triggern per IPC
    IpcHandler {
        target: "launcher"
        onMessageReceived: (message) => {
            if (message === "toggle") {
                launcher.toggle()
            }
        }
    }
}