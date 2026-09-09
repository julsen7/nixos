import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland

import "./../"
import "./../components"
import "./../components/custom"
import "./../services"

Rectangle {
    id: root

    anchors.left: parent.left

    readonly property int padding: 40

    implicitWidth: sliderSettingsRow.implicitWidth + padding
    implicitHeight: 40

    color: Theme.bg
    bottomRightRadius: height / 2

    property int currentBrightness: 50

    property var appIcons: {
        "fallback": "",
        "kitty": "",
        "zen": "",
        "code": "󰨞",
        "spotify": "",
        "discord": "",
        "obsidian": "",
        "obs": "󱜠",
        "steam": "",
        "blender": "󰂫",
        "krita": "",
        "pinta": "",
        "virtual": "󰍺",
        "prism": "",
        "minecraft": "󰍳",
        "youtube": "",
        "twitch": "",
        "github": "󰊫",
        "moodle": ""
    }

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
                onClicked: Quickshell.execDetached(["kitty"])
            }
        }

        RowLayout {
            spacing: 20

            Repeater {
                model: Hyprland.workspaces

                Rectangle {
                    id: workspaceItem

                    implicitWidth: contentRow.implicitWidth + 28
                    implicitHeight: 28

                    color: modelData.active ? Theme.accent : Theme.bg3
                    radius: height / 2

                    Behavior on implicitWidth { 
                        NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } 
                    }

                    Row {
                        id: contentRow
                        anchors.centerIn: parent
                        spacing: 6

                        CustomText {
                            visible: iconRepeater.count === 0
                            text: modelData.name
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Repeater {
                            id: iconRepeater

                            model: {
                                let list = [];
                                let toplevels = Hyprland.toplevels.values;
                                if (!toplevels) return list;

                                for (let i = 0; i < toplevels.length; i++) {
                                    let top = toplevels[i];
                                    if (top.workspace && top.workspace.id === modelData.id) {
                                        list.push(top);
                                    }
                                }
                                return list;
                            }

                            CustomText {
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: 18

                                text: {
                                    let top = modelData;
                                    let rawClass = top.lastIpcObject ? (top.lastIpcObject["class"] || "") : "";
                                    let appClass = rawClass.toLowerCase();

                                    let icon = root.appIcons[appClass];

                                    if (!icon) {
                                        for (let key in root.appIcons) {
                                            if (key !== "fallback" && appClass.includes(key)) {
                                                icon = root.appIcons[key];
                                                break;
                                            }
                                        }
                                    }

                                    return icon || root.appIcons["fallback"];
                                }
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = '" + modelData.name + "' })")
                    }
                }
            }
        }

        RowLayout {
            spacing: 10

            CustomText {
                text: PipewireService.sourceMuted ? "" : ""
                font.pixelSize: 20

                MouseArea {
                    id: mouseArea2
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: PipewireService.toggleSourceMuted()
                }
            }

            CustomSlider {
                icon: {
                    if (PipewireService.muted) return "󰖁";

                    let vol = Math.round(PipewireService.volume * 100);
                    if (vol === 0) return "";
                    if (vol < 33) return "";
                    if (vol < 66) return "";
                    return "";
                }
                maxValue: 100
                sliderValue: PipewireService.source ? Math.round(PipewireService.volume * 100) : 50
                onMoved: PipewireService.setVolume(value / 100.0)

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.RightButton
                    cursorShape: Qt.PointingHandCursor
                    onClicked: PipewireService.toggleMuted()
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