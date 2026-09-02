import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

import "./../../"

Rectangle {
    id: root

    property alias color: root.color

    property string leftIcon: ""
    property string rightIcon: ""
    property int pixelSize: 18
    property string placeholderText: ""
    property color textFieldColor: Theme.fg

    property alias echoMode: textfield.echoMode
    property alias inputMethodHints: textfield.inputMethodHints
    property alias cursorDelegate: textfield.cursorDelegate

    property alias text: textfield.text 

    implicitHeight: 50
    radius: 12

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 10

        CustomText {
            text: root.leftIcon
            color: textFieldColor
            font.pixelSize: root.pixelSize
            Layout.alignment: Qt.AlignVCenter
        }

        TextField {
            id: textfield

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            font.pixelSize: root.pixelSize
            color: textFieldColor

            placeholderText: root.placeholderText
            placeholderTextColor: Qt.alpha(textFieldColor, 0.5)

            background: Item { }

            Component.onCompleted: forceActiveFocus()

            onAccepted: {
                console.log("Eingegebener Text: " + text)
            }
        }

        CustomText {
            text: root.rightIcon
            color: textFieldColor
            font.pixelSize: root.pixelSize
            Layout.alignment: Qt.AlignVCenter
        }
    }
}