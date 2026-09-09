import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

import "./../"
import "./../components/custom"

FloatingWindow {
    id: root

    color: Theme.bg

    WrapperRectangle {
        anchors.right: parent.right
        implicitWidth: 30

        color: Theme.bg3
        bottomLeftRadius: 20

        CustomText {
            text: ""
            font.pixelSize: 18
            font.bold: true

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.visible = false
            }
        }
    }

    WrapperRectangle {
        anchors.fill: parent
        anchors.margins: 60

        color: Theme.bg2
        radius: 20

        RowLayout {
            anchors.fill: parent
            spacing: 50

            ListView {
                anchors.top: parent.top
                spacing: 40

                CustomSettingCategory {
                    titleText: "Network"
                    contentText: "WiFi & Bluetooth"
                }
            }

            ListView {
                anchors.top: parent.top
                spacing: 40

                CustomSettingCategory {
                    titleText: "Setting 1"
                    contentText: "Change it"
                }
            }
        }
    }
}