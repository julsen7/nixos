pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects

Item {
    id: root

    Rectangle {
        id: maskSource

        anchors.fill: parent
        radius: 18
        layer.enabled: true
    }

    Image {
        id: img

        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "file:///home/julsen/wallpaper/AssassinsCreed.jpg"
        asynchronous: true
        opacity: 0
        visible: false

        onStatusChanged: {
            if (status === Image.Ready)
            anim.start()
        }

        NumberAnimation on opacity {
            id: anim
            running: false
            from: 0
            to: 1
            duration: 400
            easing.type: Easing.InOutQuad
        }
    }

    MultiEffect {
        anchors.fill: parent
        source: img
        maskEnabled: true
        maskSource: maskSource
        opacity: img.opacity
    }
}