import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "./../"
import "./../components/custom"
import "./../services"

WlSessionLock {
    id: root

    Component.onCompleted: root.locked = true

    WlSessionLockSurface {
        color: "white"

        Rectangle {
            anchors.centerIn: parent

            implicitWidth: 1500
            implicitHeight: 1000

            color: Theme.bg
            radius: 20

            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 80

                // ==========================================
                // Column 1
                // ==========================================
                ColumnLayout {
                    spacing: 20

                    // 1. Wetter Modul
                    CustomLockScreenModule {
                        Layout.fillHeight: true
                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter

                            CustomText {
                                text: WeatherService.temperature
                                font.pixelSize: 32
                            }

                            CustomText {
                                text: WeatherService.weatherIcon
                                font.pixelSize: 32
                            }
                        }
                    }

                    // 2. System Info Modul
                    CustomLockScreenModule {
                        Layout.preferredHeight: 300
                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 60

                            CustomText {
                                text: ""
                                font.pixelSize: 100
                            }

                            ColumnLayout {
                                CustomText {
                                    text: "OS: Nixos"
                                    font.pixelSize: 24
                                }

                                CustomText {
                                    text: "WM: Hyprland"
                                    font.pixelSize: 24
                                }

                                CustomText {
                                    text: "USER: julsen"
                                    font.pixelSize: 24
                                }

                                CustomText {
                                    text: "UPTIME: <ZEIT>"
                                    font.pixelSize: 24
                                }
                            }
                        }
                    }

                    // 3. Media Player Modul
                    CustomLockScreenModule {
                        Layout.preferredHeight: 260

                        backgroundContent: [
                            CustomImage {
                                source: MprisService.artUrl
                                anchors.fill: parent
                            },
                            Rectangle {
                                anchors.fill: parent
                                color: "#80000000"
                            }
                        ]

                        CustomText {
                            text: MprisService.trackTitle
                            color: Theme.accent
                            font.pixelSize: 32
                            font.bold: true
                            Layout.maximumWidth: 300
                            Layout.alignment: Qt.AlignHCenter
                        }

                        CustomText {
                            text: MprisService.trackArtist
                            color: Theme.ph
                            Layout.maximumWidth: 150
                            Layout.alignment: Qt.AlignHCenter
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: 10

                            CustomButton {
                                buttonText: ""
                                radius: 10
                                color: Theme.bg3
                                Layout.preferredWidth: 50
                                Layout.preferredHeight: 30
                                onClicked: MprisService.player.previous()
                            }

                            CustomButton {
                                buttonText: MprisService.isPlaying ? "" : ""
                                radius: 10
                                color: Theme.bg3
                                Layout.preferredWidth: 50
                                Layout.preferredHeight: 30
                                onClicked: MprisService.player.togglePlaying();
                            }

                            CustomButton {
                                buttonText: ""
                                radius: 10
                                color: Theme.bg3
                                Layout.preferredWidth: 50
                                Layout.preferredHeight: 30
                                onClicked: MprisService.player.next()
                            }
                        }
                    }
                }

                // ==========================================
                // Column 2 (Zentrale Elemente - Unverändert)
                // ==========================================
                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.maximumWidth: 400
                    spacing: 50

                    Layout.topMargin: 100
                    Layout.bottomMargin: 100

                    CustomText {
                        Layout.fillWidth: true
                        text: DateTimeService.time
                        font.pixelSize: 100
                        font.bold: true
                    }

                    CustomTextField {
                        leftIcon: "󰌾"
                        rightIcon: ""
                        placeholderText: "Enter password"
                        color: Theme.bg2

                        cursorDelegate: Item { }
                        echoMode: TextInput.Password
                        inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase

                        Layout.fillWidth: true
                    }

                    CustomButton {
                        onClicked: root.locked = false
                        buttonText: "Unlock"
                        Layout.fillWidth: true
                        Layout.maximumWidth: 300
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                // ==========================================
                // Column 3
                // ==========================================
                ColumnLayout {
                    spacing: 20

                    // 1. Hardware Monitor Modul
                    CustomLockScreenModule {
                        RowLayout {
                            id: row
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 20

                            Rectangle {
                                Layout.preferredWidth: 120
                                Layout.preferredHeight: 120
                                radius: 20
                                color: "red"

                                CustomText {
                                    anchors.centerIn: parent
                                    text: "CPU"
                                }
                            }

                            Rectangle {
                                Layout.preferredWidth: 120
                                Layout.preferredHeight: 120
                                radius: 20
                                color: "blue"

                                CustomText {
                                    anchors.centerIn: parent
                                    text: "RAM"
                                }
                            }

                            Rectangle {
                                Layout.preferredWidth: 120
                                Layout.preferredHeight: 120
                                radius: 20
                                color: "yellow"

                                CustomText {
                                    anchors.centerIn: parent
                                    text: "ROM"
                                }
                            }
                        }
                    }

                    // 2. Notifications Modul
                    CustomLockScreenModule {
                        Layout.fillHeight: true

                        ColumnLayout {
                            Layout.alignment: Qt.AlignTop
                            spacing: 10

                            CustomText {
                                text: "Notifications"
                                font.bold: true
                                font.pixelSize: 22
                            }

                            ListView {
                                id: notificationList

                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                clip: true
                                spacing: 10

                                model: DesktopEntries.applications.values

                                delegate: CustomListViewElement {
                                    imageSource: "https://www.gstatic.com/youtube/img/promos/40c9bda47270818ac91a3bb3b791c405272d6f7bc364a89faa079ee5648e0962_122x56.webp"
                                    titleText: "Notification"
                                    contentText: "Content"

                                    implicitWidth: appList.width
                                    implicitHeight: 60
                                }

                                ScrollBar.vertical: ScrollBar {
                                    policy: ScrollBar.AsNeeded
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}