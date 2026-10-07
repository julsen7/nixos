import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

import "../"
import "../components"

FloatingWindow {
    id: root

    visible: GlobalState.isSettingsOpen
    color: Theme.bg

    property int currentTab: GlobalState.settingsTab
    property var categories: [" Network", "󰂯 Bluetooth", " Audio", " Battery", "Storage"]
    property var titles: ["Network", "Bluetooth", "Audio", "Battery", "Storage"]

    // close-button
    WrapperRectangle {
        anchors.right: parent.right
        anchors.top: parent.top
        implicitWidth: 30

        color: Theme.bg2
        bottomLeftRadius: 20

        CustomText {
            anchors.centerIn: parent
            text: ""
            color: hoverHandler.hovered ? Theme.red : Theme.fg
            font.pixelSize: 18
            font.bold: true

            HoverHandler { id: hoverHandler; cursorShape: Qt.PointingHandCursor }
            TapHandler { onTapped: GlobalState.isSettingsOpen = false }
        }
    }

    // main window
    WrapperRectangle {
        anchors.fill: parent
        anchors.margins: 40

        color: Theme.bg2
        radius: 20

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                Layout.preferredWidth: 220
                Layout.fillHeight: true
                color: "transparent"

                // left side
                ListView {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10

                    model: root.categories

                    delegate: Rectangle {
                        implicitWidth: ListView.view.width
                        height: 45
                        radius: 10

                        color: root.currentTab === index ? Theme.accent : (hoverHandler.hovered ? Theme.bg3 : "transparent")

                        CustomText {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                            text: modelData
                            font.pixelSize: 16
                            color: root.currentTab === index ? Theme.bg : Theme.fg
                            font.bold: root.currentTab === index
                        }

                        HoverHandler { id: hoverHandler; cursorShape: Qt.PointingHandCursor }
                        TapHandler { onTapped: GlobalState.settingsTab = index }
                    }
                }

                Rectangle {
                    anchors.right: parent.right
                    width: 1
                    height: parent.height
                    color: Theme.bg3
                }
            }

            // right side
            ColumnLayout {
                Layout.fillHeight: true
                Layout.margins: 20

                spacing: 20

                CustomText {
                    id: title
                    Layout.alignment: Qt.AlignVCenter
                    text: root.titles[currentTab]
                    font.pixelSize: 26
                    font.bold: true 
                }

                StackLayout {
                    currentIndex: root.currentTab

                    // network stack
                    ColumnLayout {
                        Layout.fillHeight: true
                        spacing: 10

                        // ethernet
                        CustomSettingsGroup {
                            text: "Ethernet"

                            mainControl: ColumnLayout {
                                spacing: 0
                                CustomText {
                                    Layout.fillWidth: true
                                    text: "Connected"
                                    color: Theme.accent
                                    horizontalAlignment: Text.AlignRight
                                }

                                CustomText {
                                    Layout.fillWidth: true
                                    text: "Data usage: 25MiB"
                                    color: Theme.fg2
                                    horizontalAlignment: Text.AlignRight
                                }
                            }

                            content: RowLayout {
                                spacing: 20

                                CustomText {
                                    text: "#"
                                    Layout.fillWidth: true
                                }

                                ColumnLayout {
                                    CustomText {
                                        text: "Kabellose Verbindung 1"
                                    }
                                    CustomText {
                                        text: "enp3s0"
                                        color: Theme.accent
                                    }
                                }

                                CustomSettingsButton {
                                    text: ""
                                    onClicked: console.log("clicked")
                                }
                            } 
                        }

                        // wifi
                        CustomSettingsGroup {
                            text: "Wi-Fi"

                            mainControl: CustomSettingsToggle {
                                activated: GlobalState.wifiEnabled
                                onToggled: (active) => console.log(active)
                            }

                            content: ListView {
                                delegate: Rectangle {
                                    implicitHeight: 20
                                    implicitWidth: 100
                                    color: "red"
                                }
                            }
                        }
                    }

                    // bluetooth stack
                    ColumnLayout {
                        Layout.fillHeight: true
                        spacing: 10

                        // bluetooth
                        CustomSettingsGroup {
                            text: "Bluetooth"

                            mainControl: CustomSettingsToggle {
                                activated: GlobalState.bluetoothEnabled
                                onToggled: (active) => console.log(active)
                            }

                            content: ListView {
                                delegate: Rectangle {
                                    implicitHeight: 20
                                    implicitWidth: 100
                                    color: "red"
                                }
                            }
                        }
                    }

                    // audio stack
                    ColumnLayout {
                        Layout.fillHeight: true
                        spacing: 10

                        // output
                        CustomSettingsGroup {
                            text: "Output"

                            mainControl: CustomSettingsToggle {
                                activated: GlobalState.bluetoothEnabled
                                onToggled: (active) => console.log(active)
                            }

                            content: ListView {
                                delegate: Rectangle {
                                    implicitHeight: 20
                                    implicitWidth: 100
                                    color: "red"
                                }
                            }
                        }

                        // input
                        CustomSettingsGroup {
                            text: "Input"

                            mainControl: CustomSettingsToggle {
                                activated: GlobalState.bluetoothEnabled
                                onToggled: (active) => console.log(active)
                            }

                            content: ListView {
                                delegate: Rectangle {
                                    implicitHeight: 20
                                    implicitWidth: 100
                                    color: "red"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}