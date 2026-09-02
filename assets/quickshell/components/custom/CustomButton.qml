import QtQuick
import QtQuick.Controls
import Quickshell

import "./../../"

Button {
    id: root

    property string buttonText: ""
    property int radius: height / 2
    property color color: Theme.fg

    implicitHeight: 40

    background: Rectangle {
        radius: root.radius
        color: hoverHandler.hovered ? root.color : Theme.accent

        Behavior on color { ColorAnimation { duration: 200; easing.type: Easing.InOutCubic } }
    }

    contentItem: CustomText {
        text: root.buttonText
        color: hoverHandler.hovered ? Theme.accent : root.color
    }

    HoverHandler {
        id: hoverHandler
        cursorShape: Qt.PointingHandCursor
    }
}