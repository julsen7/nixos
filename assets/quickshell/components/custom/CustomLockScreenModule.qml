import QtQuick
import QtQuick.Layouts
import Quickshell

import "./../../"

Rectangle {
    id: root

    Layout.fillWidth: true

    color: Theme.bg_hov
    radius: 20
    clip: true

    property alias backgroundContent: bgContainer.data
    default property alias content: innerLayout.data

    implicitWidth: innerLayout.implicitWidth + 40
    implicitHeight: innerLayout.implicitHeight + 40

    Item {
        id: bgContainer
        anchors.fill: parent
        z: 0
    }

    ColumnLayout {
        id: innerLayout
        anchors.fill: parent
        anchors.margins: 20
        z: 1
    }
}