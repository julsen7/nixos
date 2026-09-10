import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Scope {
    id: root

    NotificationServer {
        id: server

        bodyImagesSupported: true
        actionsSupported: true
        imageSupported: true

        onNotification: n => {
            console.log("got: " + n.summary + "---" + n.body)
            n.tracked = true
        }
    }

    PanelWindow {
        anchors {
            top: true
            right: true
        }
        margins {
            top: 12
            right: 12
        }

        implicitWidth: 380
        implicitHeight: Math.max(1, column.implicitHeight)
        color: "transparent"

        exclusionMode: ExclusionMode.Ignore

    }
}