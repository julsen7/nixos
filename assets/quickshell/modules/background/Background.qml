import QtQuick
import Quickshell
import Quickshell.Wayland

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: win

            required property var modelData
            screen: modelData

            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Background
            
            color: "black"
            surfaceFormat.opaque: false

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            Item {
                id: behindClock

                anchors.fill: parent

                Wallpaper {
                    id: wallpaper

                    anchors.fill: parent
                }

                Visualiser {
                    anchors.fill: parent
                    screen: win.modelData
                    wallpaper: wallpaper
                }
            }
        }
    }
}
