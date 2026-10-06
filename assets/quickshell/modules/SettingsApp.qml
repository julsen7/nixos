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
    property var categories: [" Network", "󰂯 Bluetooth", " Audio", " Battery"]
    property var titles: ["Network", "Bluetooth", "Audio", "Battery"]

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
                Layout.margins: 30

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

                    ColumnLayout {
                        Layout.fillHeight: true
                        spacing: 20

                        RowLayout {
                            spacing: 10

                            Rectangle {
                                Layout.alignment: Qt.AlignVCenter
                                color: Theme.ph

                                implicitWidth: 40
                                implicitHeight: 40

                                radius: 10

                                CustomText {
                                    anchors.centerIn: parent
                                    text: ""
                                    font.pixelSize: 20
                                    color: Theme.fg
                                }

                                HoverHandler { cursorShape: Qt.PointingHandCursor }
                                TapHandler { onTapped: console.log("search") }
                            }

                            Rectangle {
                                Layout.alignment: Qt.AlignVCenter
                                color: Theme.accent

                                implicitWidth: 40
                                implicitHeight: 40

                                radius: 10

                                CustomText {
                                    anchors.centerIn: parent
                                    text: "+"
                                    font.pixelSize: 30
                                    color: Theme.fg
                                }

                                HoverHandler { cursorShape: Qt.PointingHandCursor }
                                TapHandler { onTapped: console.log("add") }
                            }
                        }

                        CustomSettingsToggle {
                            text: "Enable WiFi"
                            isActivated: GlobalState.wifiEnabled

                            onToggled: (active) => {
                                console.log("Neuer Status:", active)
                                if (active) {
                                    // Logik fürs Einschalten
                                } else {
                                    // Logik fürs Ausschalten
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}