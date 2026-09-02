import QtQuick
import QtQuick.Layouts
import Quickshell

import "./../"
import "./../components/custom"

Rectangle {
    id: root

    anchors.right: parent.right

    readonly property int padding: 40

    implicitWidth: controlCenterRow.implicitWidth + padding
    implicitHeight: 40

    color: Theme.bg
    bottomLeftRadius: height / 2

    HoverHandler {
        id: hoverHandler
        margin: root.height
    }

    y: hoverHandler.hovered ? 0 : -height

    Behavior on y { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }

    RowLayout {
        id: controlCenterRow

        anchors.leftMargin: padding / 2
        anchors.rightMargin: padding / 2

        anchors.fill: parent
        spacing: 20

        RowLayout {
            spacing: 10

            CustomTopSetting {
                icon: "󰂯"
                command: "bluetoothctl devices connected | wc -l"
                interval: 5000
            }

            CustomTopSetting {
                icon: ""
                command: "nmcli -t -f NAME connection show --active | head -n1"
                interval: 5000
            }

            CustomTopSetting {
                icon: ""
                command: "cat /sys/class/power_supply/BAT1/capacity"
                interval: 5000
            }
        }

        CustomText {
            text: ""
            font.pixelSize: 24
            color: mouseArea.containsMouse ? "#ff5555" : Theme.fg

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: console.log("test")
            }
        }
    }
}