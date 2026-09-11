import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

import "./../"
import "./../components/custom"

Rectangle {
    id: root

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

            Repeater {
                model: SystemTray.items

                CustomImage {
                    required property SystemTrayItem modelData
                    source: modelData.icon
                    implicitWidth: 20
                    implicitHeight: 20
                }
            }
        }

        CustomTopSetting {
            icon: "󰂯"
            command: "bluetoothctl devices connected | wc -l"
            interval: 5000
        }

        CustomTopSetting {
            command: "nmcli -t -f TYPE,NAME connection show --active | head -n1 | awk -F: 'BEGIN{i=\"\"; v=\"Keine Verbindung\"} {if($1 ~ \"ethernet\"){i=\"󰌗\"; v=\"LAN\"} else if($1 ~ \"wireless\"){i=\"\"; v=$2}} END{print i\"\\t\"v}'"
            interval: 5000
        }

        CustomTopSetting {
            command: "cat /sys/class/power_supply/BAT1/capacity | awk '{c=$1; if(c<20)i=\"\"; else if(c<40)i=\"\"; else if(c<60)i=\"\"; else if(c<80)i=\"\"; else i=\"\"; print i\"\\t\"c\"%\"}'"
            interval: 5000
        }

        CustomText {
            text: ""
            font.pixelSize: 22
            color: mouseArea.containsMouse ? Theme.red : Theme.fg

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: LockScreen.locked = true
            }
        }
    }
}