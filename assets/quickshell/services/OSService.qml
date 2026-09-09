pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string osName: "Loading..."
    property string wmName: "Loading..."
    property string username: "Loading..."
    property string uptime: "Loading..."

    Process {
        id: staticProc
        running: true
        command: [
            "bash", "-c",
            "source /etc/os-release 2>/dev/null; echo \"${NAME:-Linux}|${XDG_CURRENT_DESKTOP:-${DESKTOP_SESSION:-Unknown}}|${USER:-$LOGNAME}\""
        ]
        stdout: SplitParser {
            onRead: data => {
                let parts = data.trim().split("|");
                if (parts.length >= 3) {
                    root.osName = parts[0];
                    root.wmName = parts[1];
                    root.username = parts[2];
                }
            }
        }
    }

    Process {
        id: uptimeProc
        running: true
        command: ["bash", "-c", "uptime -p | sed 's/up //'"]
        stdout: SplitParser {
            onRead: data => root.uptime = data.trim()
        }
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: uptimeProc.running = true
    }
}