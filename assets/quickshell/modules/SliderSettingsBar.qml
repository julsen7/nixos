import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
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

    HoverHandler {
        id: hoverHandler
        margin: root.height
    }

    y: hoverHandler.hovered ? 0 : -height

    Behavior on y { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }

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
                sliderValue: 50

                onMoved: {
                    if (Pipewire.defaultAudioSink) {
                        Pipewire.defaultAudioSink.audio.volume = value / 100.0
                    }
                }
            }

            CustomSlider {
                icon: "󰃞"
                sliderValue: 50
                maxValue: 100
            }
        }
    }
}