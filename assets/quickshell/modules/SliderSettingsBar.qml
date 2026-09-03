import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

import "./../"
import "./../components"
import "./../components/custom"

Rectangle {
    id: root

    anchors.left: parent.left

    readonly property int padding: 40

    implicitWidth: sliderSettingsRow.implicitWidth + padding
    implicitHeight: 40

    color: Theme.bg
    bottomRightRadius: height / 2

    property int currentBrightness: 50

    HoverHandler {
        id: hoverHandler
        margin: root.height
    }

    y: hoverHandler.hovered ? 0 : -height

    Behavior on y { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }

    Process {
        id: brightnessSetProcess
    }

    Process {
        running: true
        command: ["sh", "-c", "brightnessctl -m | cut -d, -f4 | tr -d %"]
        stdout: StdioCollector {
            onStreamFinished: {
                let val = parseInt(this.text.trim())
                if (!isNaN(val)) {
                    root.currentBrightness = val
                }
            }
        }
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    RowLayout {
        id: sliderSettingsRow

        anchors.leftMargin: padding / 2
        anchors.rightMargin: padding / 2

        anchors.fill: parent
        spacing: 20

        CustomText {
            text: ""
            font.pixelSize: 18

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: console.log("")
            }
        }

        Workspaces { }

        RowLayout {
            spacing: 10

            CustomText {
                text: ""
                font.pixelSize: 20
            }

            CustomSlider {
                icon: (Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.audio.muted) ? "󰖁" : ""
                maxValue: 100

                sliderValue: Pipewire.defaultAudioSink ? Math.round(Pipewire.defaultAudioSink.audio.volume * 100) : 50

                onMoved: {
                    if (Pipewire.defaultAudioSink) {
                        try {
                            Pipewire.defaultAudioSink.audio.volume = value / 100.0
                        } catch (e) {
                            console.log("Pipewire node not fully bound yet.")
                        }
                    }
                }
            }

            CustomSlider {
                icon: "󰃞"
                maxValue: 100
                sliderValue: root.currentBrightness

                onMoved: {
                    brightnessSetProcess.command = ["brightnessctl", "set", Math.round(value) + "%"]
                    brightnessSetProcess.running = true
                }
            }
        }
    }
}