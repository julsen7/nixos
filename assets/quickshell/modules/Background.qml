import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland

import "./../"

Scope {
    id: root

    property string wallpaperPath: ""

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: window

            required property var modelData
            screen: modelData

            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Background

            color: "transparent"

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            Rectangle {
                id: borderRoot
                anchors.fill: window.contentItem
                color: Theme.bg
                radius: 0

                Rectangle {
                    id: maskSource
                    anchors.fill: wallpaper
                    radius: 20
                    layer.enabled: true
                    visible: false
                }

                Image {
                    id: wallpaper

                    anchors.fill: parent
                    anchors.margins: 4

                    fillMode: Image.PreserveAspectCrop
                    source: root.wallpaperPath
                    asynchronous: true
                    visible: false
                    opacity: 0

                    onSourceChanged: {
                        opacity = 0
                    }

                    onStatusChanged: {
                        if (status === Image.Ready) {
                            anim.restart()
                        }
                    }

                    NumberAnimation on opacity {
                        id: anim
                        from: 0
                        to: 1
                        duration: 400
                        easing.type: Easing.InOutQuad
                    }
                }

                MultiEffect {
                    anchors.fill: wallpaper
                    source: wallpaper
                    maskEnabled: true
                    maskSource: maskSource
                }
            }
        }
    }
}