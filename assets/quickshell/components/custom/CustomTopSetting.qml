import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "./../../"

RowLayout {
    id: root

    Layout.alignment: Qt.AlignVCenter
    spacing: 10

    property string command: ""
    property string value: ""

    property alias interval: timer.interval
    property alias icon: icon.text

    Process {
        id: process
        command: ["sh", "-c", root.command]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.value = text.trim()
        }
    }

    Timer {
        id: timer
        running: true
        repeat: true
        onTriggered: process.running = true
    }

    CustomText {
        id: icon
        color: Theme.accent
        font.pixelSize: 18
        Layout.alignment: Qt.AlignVCenter
    }

    CustomText {
        text: root.value
        font.pixelSize: 18
        Layout.alignment: Qt.AlignVCenter
    }
}