import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

import "../"

WrapperRectangle {
    id: root

    property bool isActivated: false
    property alias text: content.text

    signal toggled(bool active)

    Layout.fillWidth: true
    Layout.preferredHeight: 48

    radius: 10
    margin: 10

    color: Theme.ph

    TapHandler {
        onTapped: {
            root.isActivated = !root.isActivated
            root.toggled(root.isActivated)
        }
    }

    RowLayout {
        CustomText {
            id: content
            color: Theme.fg
        }

        Rectangle {
            id: switchTrack
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            implicitWidth: 46
            implicitHeight: 24
            radius: height / 2

            color: root.isActivated ? Theme.accent : Theme.bg2

            Behavior on color { ColorAnimation { duration: 150 } }

            Rectangle {
                id: switchKnob
                width: 18
                height: 18
                radius: width / 2
                color: "#ffffff"
                anchors.verticalCenter: parent.verticalCenter
                
                x: root.isActivated ? (switchTrack.width - width - 3) : 3

                Behavior on x { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
            }
        }
    }
}