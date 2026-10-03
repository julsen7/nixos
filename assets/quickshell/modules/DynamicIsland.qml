import QtQuick
import QtQuick.Layouts
import Quickshell

import "../"
import "../components"
import "../services"

Rectangle {
  id: root

  readonly property int padding: 40

  implicitWidth: hoverHandler.hovered ? (contentLayout.implicitWidth + padding) : 140
  implicitHeight: hoverHandler.hovered ? (contentLayout.implicitHeight + padding) : 40

  color: Theme.bg
  bottomLeftRadius: 20
  bottomRightRadius: 20

  Behavior on implicitWidth { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }
  Behavior on implicitHeight { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }

  HoverHandler {
    id: hoverHandler
    margin: root.height
  }

  CustomText {
    text: DateTimeService.time
    font.pixelSize: 20
    font.bold: true

    anchors.centerIn: parent

    opacity: hoverHandler.hovered ? 0 : 1
    visible: opacity > 0

    Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }
  }

  RowLayout {
    id: contentLayout

    anchors.centerIn: parent

    spacing: 30

    opacity: hoverHandler.hovered ? 1 : 0
    visible: opacity > 0

    Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }

    // Media-Widget
    RowLayout {
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

    // Calendar-Widget
    ColumnLayout {
      CustomText {
          text: DateTimeService.time
          font.pixelSize: 36
          font.bold: true
          Layout.alignment: Qt.AlignHCenter
      }

      RowLayout {
          spacing: 12
          Layout.alignment: Qt.AlignHCenter

          CustomText {
              text: DateTimeService.yesterdayDayName + "\n" + DateTimeService.yesterdayDayNumber
              color: Theme.fg2
          }

          CustomText {
              text: DateTimeService.weekDayName + "\n" + DateTimeService.dayDateNumber
              color: Theme.accent
              font.bold: true
          }

          CustomText {
              text: DateTimeService.tomorrowDayName + "\n" + DateTimeService.tomorrowDayNumber
              color: Theme.fg2
          }
      }
    }

    // Weather-Widget
    ColumnLayout {
      spacing: 20

      RowLayout {
        spacing: 30

        CustomText {
          text: WeatherService.icon
          font.pixelSize: 60
          font.bold: true
        }

        ColumnLayout {
          CustomText {
            text: WeatherService.temp
            font.pixelSize: 34
            font.bold: true
          }

          CustomText {
            text: WeatherService.description
            font.bold: true
          }
        }
      }

      RowLayout {
        Layout.alignment: Qt.AlignHCenter

        spacing: 10

        CustomText {
          text: "  " + WeatherService.sunrise
          font.pixelSize: 16
        }

        CustomText {
          text: "  " + WeatherService.sunset
          font.pixelSize: 16
        }
      }
    }
  }
}