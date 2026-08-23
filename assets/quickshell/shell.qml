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
            height: 40

            // Transparentes Fenster für schwebendes Design
            color: "transparent"

            // Reserviert Platz in Hyprland (wie Waybar)
            exclusionMode: ExclusionMode.Exclusive

            // Lade die eigentliche Bar-Komponente
            TopBar {
                anchors.fill: parent
            }
        }
    }
}