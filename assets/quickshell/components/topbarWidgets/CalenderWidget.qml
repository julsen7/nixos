import QtQuick
import QtQuick.Layouts
import Quickshell

import "./../../"
import "./../../components/custom"
import "./../../services"

ColumnLayout {
    id: root

    CustomText {
        text: DateTimeService.time
        font.pixelSize: 36
        font.bold: true
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