import QtQuick
import Quickshell
import Quickshell.Wayland

import "./modules"

ShellRoot {
    // Erzeugt die Bar auf allen verbundenen Monitoren
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            // Wayland Layer-Shell Konfiguration
            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 40

            color: "transparent"

            exclusionMode: PanelWindow.ExclusionMode.Exclusive

            TopBar {
                anchors.fill: parent
            }
        }
    }
}