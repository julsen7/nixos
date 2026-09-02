import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import "./../"

RowLayout {
    id: root

    spacing: 20

    Repeater {
        model: Hyprland.workspaces

        Rectangle {
            implicitWidth: modelData.active ? 14 : 8
            implicitHeight: implicitWidth

            color: modelData.active ? Theme.accent : Theme.bg3
            radius: height / 2

            Behavior on implicitWidth { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }
        }
    }
}