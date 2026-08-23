import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

Scope {
    id: launcherScope

    property bool open: false

    function toggle() {
        open = !open
    }

    PanelWindow {
        id: window
        visible: launcherScope.open || anim.running

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        color: "transparent"
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: launcherScope.open ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

        MouseArea {
            anchors.fill: parent
            onClicked: launcherScope.open = false
        }

        Rectangle {
            id: panel
            width: 500
            height: 400
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#1e1e2e"
            radius: 20
            border.color: "#313244"
            border.width: 1

            property real targetY: launcherScope.open ? parent.height - height - 40 : parent.height + 50
            y: targetY

            Behavior on y {
                NumberAnimation {
                    id: anim
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }

            MouseArea {
                anchors.fill: parent
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15

                TextField {
                    id: searchInput
                    Layout.fillWidth: true
                    placeholderText: "App suchen..."
                    font.pixelSize: 14
                    font.family: "JetBrainsMono Nerd Font"
                    color: "#cdd6f4"

                    background: Rectangle {
                        color: "#11111b"
                        radius: 10
                    }

                    Keys.onEscapePressed: launcherScope.open = false
                }

                ListView {
                    id: appList
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    spacing: 8

                    // Nutzt das eingebaute Applications-Singleton von Quickshell
                    model: Applications.list

                    delegate: Rectangle {
                        required property var modelData
                        
                        // Einfacher Suchfilter
                        visible: searchInput.text === "" || modelData.name.toLowerCase().includes(searchInput.text.toLowerCase())
                        height: visible ? 50 : 0

                        width: appList.width
                        color: itemMouse.containsMouse ? "#313244" : "transparent"
                        radius: 10

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            anchors.rightMargin: 10
                            spacing: 12

                            IconImage {
                                source: modelData.icon ?? "application-x-executable"
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                            }

                            Text {
                                text: modelData.name
                                color: "#cdd6f4"
                                font.pixelSize: 14
                                font.bold: true
                                Layout.fillWidth: true
                            }
                        }

                        MouseArea {
                            id: itemMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                modelData.execute()
                                launcherScope.open = false
                            }
                        }
                    }
                }
            }
        }
    }
}