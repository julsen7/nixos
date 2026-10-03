import QtQuick
import QtQuick.Layouts
import Quickshell

import "../../"
import "../../components/custom"
import "../../services"

RowLayout {
    id: root

    spacing: 20

    Item {
        Layout.preferredWidth: 120
        Layout.preferredHeight: 120

        CustomImage {
            anchors.fill: parent
            source: MprisService.artUrl
        }

        Rectangle {
            width: 30
            height: 30
            radius: 8
            color: Theme.bg
            border.color: Theme.bg3
            border.width: 1
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 8

            CustomText {
                text: MprisService.playerIcon
                anchors.centerIn: parent
                font.pixelSize: 14
            }
        }
    }

    ColumnLayout {
        spacing: 10

        CustomText {
            text: MprisService.trackTitle
            font.pixelSize: 18
            font.bold: true
            Layout.maximumWidth: 200
            Layout.alignment: Qt.AlignLeft
        }

        CustomText {
            text: MprisService.trackArtist
            color: Theme.ph
            Layout.maximumWidth: 200
            Layout.alignment: Qt.AlignLeft
        }

        RowLayout {
            spacing: 10

            CustomButton {
                buttonText: ""
                radius: 10
                color: Theme.bg3
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                onClicked: MprisService.player.previous()
            }

            CustomButton {
                buttonText: MprisService.isPlaying ? "" : ""
                radius: 10
                color: Theme.bg3
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                onClicked: MprisService.player.togglePlaying();
            }

            CustomButton {
                buttonText: ""
                radius: 10
                color: Theme.bg3
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                onClicked: MprisService.player.next()
            }
        }
    }
}