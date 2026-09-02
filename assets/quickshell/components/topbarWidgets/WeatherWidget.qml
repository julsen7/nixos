import QtQuick
import QtQuick.Layouts
import Quickshell

import "./../../"
import "./../../components/custom"
import "./../../services"

ColumnLayout {
    id: root

    RowLayout {
        spacing: 10

        Rectangle {
            implicitWidth: 160
            implicitHeight: 80

            color: Theme.ph
            radius: 20

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10

                CustomText {
                    text: WeatherService.weatherIcon
                    font.pixelSize: 60
                    font.bold: true
                    Layout.alignment: Qt.AlignVCenter
                }

                CustomText {
                    text: WeatherService.temperature
                    font.bold: true
                    font.pixelSize: 26
                    Layout.alignment: Qt.AlignVCenter
                }
            }
        }
    }

    RowLayout {
        CustomText {
            text: "Sunrise"
        }

        CustomText {
            text: "Sunset"
        }
    }
}