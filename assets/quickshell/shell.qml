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
        onMessageReceived: (message) => {
            if (message === "toggle") {
                launcher.toggle()
            }
        }
    }
}