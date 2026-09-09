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
                spacing: 60

                // ==========================================
                // COLUMN 1: Weather | System Info | Media
                // ==========================================
                ColumnLayout {
                    Layout.preferredWidth: 1
                    spacing: 20

                    // 1. Weather Module
                    CustomLockScreenModule {
                        Layout.fillHeight: true

                        CustomText {
                            text: WeatherService.description
                            font.pixelSize: 18
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        CustomText {
                            text: WeatherService.temp + " " + WeatherService.icon
                            font.pixelSize: 36
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        CustomText {
                            text: "Feels like " + WeatherService.feelsLike
                            opacity: 0.8
                            Layout.alignment: Qt.AlignHCenter
                        }

                        CustomText {
                            text: "High " + WeatherService.tempHigh + " • Low " + WeatherService.tempLow
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Rectangle {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: Theme.bg2
                            radius: 16

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 10

                                CustomText {
                                    text: "󰥔 Hourly forecast"
                                    font.bold: true
                                }

                                RowLayout {
                                    Layout.alignment: Qt.AlignHCenter
                                    spacing: 8

                                    Repeater {
                                        model: WeatherService.hourlyForecast

                                        ColumnLayout {
                                            spacing: 2
                                            Layout.alignment: Qt.AlignHCenter

                                            CustomText {
                                                text: modelData.tempC + "°"
                                                font.bold: true
                                                Layout.alignment: Qt.AlignHCenter
                                            }

                                            CustomText {
                                                text: modelData.icon
                                                font.pixelSize: 20
                                                Layout.alignment: Qt.AlignHCenter
                                            }

                                            CustomText {
                                                text: modelData.precipChance + "%"
                                                opacity: 0.7
                                                color: modelData.precipChance > 30 ? "#89b4fa" : Theme.fg
                                                Layout.alignment: Qt.AlignHCenter
                                            }

                                            CustomText {
                                                text: modelData.hour
                                                font.bold: index === 0
                                                Layout.alignment: Qt.AlignHCenter
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // 2. System Info Module
                    CustomLockScreenModule {
                        Layout.preferredHeight: 300

                        CustomText {
                            text: " julsen.sh"
                            font.pixelSize: 18
                            opacity: 0.6
                        }

                        RowLayout {
                            spacing: 40
                            Layout.alignment: Qt.AlignVCenter

                            CustomText {
                                text: ""
                                font.pixelSize: 120
                                font.bold: true
                                color: Theme.accent
                            }

                            ColumnLayout {
                                spacing: 4
                                CustomText {
                                    text: "OS   : " + OSService.osName
                                    font.bold: true
                                    font.pixelSize: 22
                                }

                                CustomText {
                                    text: "WM   : " + OSService.wmName
                                    font.bold: true
                                    font.pixelSize: 22
                                }

                                CustomText {
                                    text: "USER : " + OSService.username
                                    font.bold: true
                                    font.pixelSize: 22
                                }

                                CustomText {
                                    text: "UP   : " + OSService.uptime
                                    font.bold: true
                                    font.pixelSize: 22
                                }
                            }
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 10
                            Repeater {
                                model: ["#f38ba8", "#fab387", "#f9e2af", "#a6e3a1", "#89dceb", "#b4befe", "#cba6f7"]
                                Rectangle {
                                    width: 16
                                    height: 16
                                    radius: 6
                                    color: modelData
                                }
                            }
                        }
                    }

                    // 3. Media Player Modul
                    CustomLockScreenModule {
                        Layout.preferredHeight: 240

                        backgroundContent: [
                            CustomImage {
                                source: MprisService.artUrl
                                anchors.fill: parent
                                opacity: 0.25
                            },
                            Rectangle {
                                anchors.fill: parent
                                color: Qt.rgba(0, 0, 0, 0.06)
                            }
                        ]

                        CustomText {
                            text: MprisService.trackTitle
                            color: Theme.accent
                            font.pixelSize: 18
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        CustomText {
                            text: MprisService.trackArtist
                            Layout.alignment: Qt.AlignHCenter
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 10

                            CustomButton {
                                buttonText: ""
                                backgroundColor: Theme.bg
                                Layout.preferredWidth: 40
                                Layout.preferredHeight: 40
                                onClicked: MprisService.player.previous()
                            }

                            CustomButton {
                                buttonText: MprisService.isPlaying ? "" : ""
                                radius: 12
                                Layout.preferredWidth: 60
                                Layout.preferredHeight: 40
                                onClicked: MprisService.player.togglePlaying()
                            }

                            CustomButton {
                                buttonText: ""
                                backgroundColor: Theme.bg
                                Layout.preferredWidth: 40
                                Layout.preferredHeight: 40
                                onClicked: MprisService.player.next()
                            }
                        }
                    }
                }

                // ==========================================
                // COLUMN 2: Clock | Avatar | Unlock Bar
                // ==========================================
                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    
                    Layout.preferredWidth: 400
                    Layout.minimumWidth: 400
                    Layout.maximumWidth: 400

                    spacing: 50

                    // Clock & Date
                    ColumnLayout {
                        Layout.alignment: Qt.AlignHCenter

                        CustomText {
                            text: DateTimeService.time
                            font.pixelSize: 110
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                        }

                        CustomText {
                            text: Qt.formatDate(new Date(), "dddd • d MMM").toUpperCase()
                            font.bold: true
                            opacity: 0.7
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }

                    // Avatar / Icon
                    Rectangle {
                        Layout.preferredWidth: 150
                        Layout.preferredHeight: 150
                        Layout.alignment: Qt.AlignHCenter
                        color: Theme.bg2
                        radius: height / 2
                        border.color: Qt.rgba(1, 1, 1, 0.15)
                        border.width: 4

                        CustomText {
                            anchors.centerIn: parent
                            text: ""
                            font.pixelSize: 50
                        }
                    }

                    // Passwort field
                    CustomTextField {
                        leftIcon: "󰌾"
                        rightIcon: ""
                        placeholderText: "Enter password"
                        color: Theme.bg2

                        cursorDelegate: Item { }
                        echoMode: TextInput.Password
                        inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase

                        Layout.fillWidth: true
                        Layout.preferredHeight: 48
                        onAccepted: root.locked = false
                    }

                    CustomButton {
                        buttonText: "Unlock"
                        onClicked: root.locked = false
                        Layout.preferredWidth: 300
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                // ==========================================
                // COLUMN 3: Hardware | Notifications
                // ==========================================
                ColumnLayout {
                    Layout.preferredWidth: 1 
                    spacing: 20

                    // 1. Hardware Monitor Modul
                    CustomLockScreenModule {
                        Layout.preferredHeight: 125

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 14
                            spacing: 12

                            // CPU
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                radius: 14
                                color: Qt.rgba(1, 1, 1, 0.05)

                                ColumnLayout {
                                    anchors.centerIn: parent

                                    CustomText { 
                                        text: "󰍛 64°C"
                                        font.pixelSize: 13
                                        font.bold: true
                                        color: "#a6e3a1"
                                    }

                                    CustomText { 
                                        text: "2%"
                                        font.pixelSize: 22
                                        font.bold: true
                                    }
                                }
                            }

                            // RAM
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                radius: 14
                                color: Qt.rgba(1, 1, 1, 0.05)

                                ColumnLayout {
                                    anchors.centerIn: parent

                                    CustomText { 
                                        text: "󰘚 RAM"
                                        font.pixelSize: 13
                                        font.bold: true
                                    }

                                    CustomText {
                                        text: "56%"
                                        font.pixelSize: 22
                                        font.bold: true
                                    }
                                }
                            }

                            // Battery
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                radius: 14
                                color: Qt.rgba(1, 1, 1, 0.05)

                                ColumnLayout {
                                    anchors.centerIn: parent
                                    CustomText {
                                        text: "󰁹 BAT"
                                        font.pixelSize: 13
                                        font.bold: true
                                        color: "#a6e3a1"
                                    }

                                    CustomText {
                                        text: "39%"
                                        font.pixelSize: 22
                                        font.bold: true
                                        color: "#a6e3a1"
                                    }
                                }
                            }
                        }
                    }

                    // 2. Notification Module
                    CustomLockScreenModule {
                        Layout.fillHeight: true

                        ColumnLayout {
                            anchors.fill: parent

                            CustomText {
                                text: "Notifications"
                                font.bold: true
                                font.pixelSize: 18
                                Layout.alignment: Qt.AlignTop
                            }

                            // ListView {
                            //     id: notificationList

                            //     Layout.fillWidth: true
                            //     Layout.fillHeight: true

                            //     clip: true
                            //     spacing: 10

                            //     visible: count > 0 

                            //     model: DesktopEntries.applications.values

                            //     delegate: CustomListViewElement {
                            //         imageSource: ""
                            //         titleText: "Notification"
                            //         contentText: "Content"

                            //         implicitWidth: notificationList.width
                            //         implicitHeight: 60
                            //     }

                            //     ScrollBar.vertical: ScrollBar {
                            //         policy: ScrollBar.AsNeeded
                            //         contentItem: Rectangle {
                            //             implicitWidth: 6
                            //             radius: width / 2
                            //             color: Theme.accent
                            //         }
                            //     }
                            // }

                            ColumnLayout {
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                
                                visible: notificationList.count === 0

                                CustomText {
                                    text: "󰂛"
                                    font.pixelSize: 55
                                    opacity: 0.3
                                    Layout.alignment: Qt.AlignHCenter
                                }

                                CustomText {
                                    text: "No Notifications"
                                    font.pixelSize: 15
                                    opacity: 0.5
                                    Layout.alignment: Qt.AlignHCenter
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}