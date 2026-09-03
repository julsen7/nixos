import QtQuick
import QtQuick.Layouts
import Quickshell

import "./../"
import "./../components/custom"

Item {
    id: root

    property string wallpaperUrl: ""
    
    property bool isCurrentItem: PathView.isCurrentItem 
    property int itemIndex: index

    signal itemClicked(int idx, bool wasAlreadyCurrent)

    implicitWidth: 200
    implicitHeight: 120

    Rectangle {
        id: visualContainer
        anchors.centerIn: parent

        width: root.isCurrentItem ? 200 : 170
        height: root.isCurrentItem ? 120 : 90
        opacity: root.isCurrentItem ? 1.0 : 0.5

        radius: 20
        clip: true

        layer.enabled: true

        Behavior on width { NumberAnimation { duration: 250; easing.type: Easing.OutQuart } }
        Behavior on height { NumberAnimation { duration: 250; easing.type: Easing.OutQuart } }
        Behavior on opacity { NumberAnimation { duration: 250; easing.type: Easing.OutQuart } }

        border.color: root.isCurrentItem ? "white" : "transparent"
        border.width: root.isCurrentItem ? 2 : 0

        CustomImage {
            source: root.wallpaperUrl
            anchors.fill: parent
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.itemClicked(root.itemIndex, root.isCurrentItem)
        }
    }
}