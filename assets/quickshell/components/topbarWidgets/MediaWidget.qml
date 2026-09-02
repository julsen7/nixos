import QtQuick
import QtQuick.Layouts
import Quickshell

import "./../../"
import "./../../components/custom"
import "./../../services"

RowLayout {
    id: root

    spacing: 20

    CustomImage {
        source: MprisService.artUrl
        Layout.preferredWidth: 120
        Layout.preferredHeight: 120
    }

    ColumnLayout {
        spacing: 10

        CustomText {
            text: MprisService.trackTitle
            font.pixelSize: 18
            font.bold: true
            Layout.maximumWidth: 150
            Layout.alignment: Qt.AlignLeft
        }

        CustomText {
            text: MprisService.trackArtist
            color: Theme.ph
            Layout.maximumWidth: 150
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