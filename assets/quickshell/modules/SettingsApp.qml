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

                Rectangle {
                    anchors.right: parent.right
                    width: 1
                    height: parent.height
                    color: Theme.bg3
                }

                ListView {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10

                    model: root.categories

                    delegate: Rectangle {
                        width: ListView.view.width
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
            }

            // RECHTE SEITE: CONTENT (StackLayout)
            StackLayout {
                currentIndex: root.currentTab
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.margins: 30

                ColumnLayout {
                    spacing: 20
                    CustomText { text: "Network"; font.pixelSize: 24; font.bold: true }
                    CustomText { text: "nmcli connections here..."; color: Theme.fg2; Layout.fillHeight: true; Layout.alignment: Qt.AlignTop }
                }

                ColumnLayout {
                    spacing: 20
                    CustomText { text: "Bluetooth"; font.pixelSize: 24; font.bold: true }
                    CustomText { text: "Run 'bluetoothctl devices' here..."; color: Theme.fg2; Layout.fillHeight: true; Layout.alignment: Qt.AlignTop }
                }

                ColumnLayout {
                    spacing: 20
                    CustomText { text: "Audio"; font.pixelSize: 24; font.bold: true }
                    CustomText { text: "Volume Sliders (wpctl set-volume) go here..."; color: Theme.fg2; Layout.fillHeight: true; Layout.alignment: Qt.AlignTop }
                }

                ColumnLayout {
                    spacing: 20
                    CustomText { text: "Battery"; font.pixelSize: 24; font.bold: true }
                    CustomText { text: "battery"; color: Theme.fg2; Layout.fillHeight: true; Layout.alignment: Qt.AlignTop }
                }
            }
        }
    }
}