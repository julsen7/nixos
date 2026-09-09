import QtQuick
import QtQuick.Layouts
import Quickshell

import "./../../"
import "./../../components/custom"
import "./../../services"

ColumnLayout {
    id: root

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