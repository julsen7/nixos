import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
    spacing: 8

    // Iteriert nativ über die aktiven Hyprland Workspaces
    Repeater {
        model: 6 // 6 Workspaces wie in deiner Config

        Rectangle {
            required property int index
            id: wsRect

            property int wsId: index + 1
            property bool isActive: Hyprland.focusedWorkspace?.id === wsId

            width: isActive ? 24 : 10
            height: 10
            radius: 5

            color: isActive ? "#d0bcff" : "#49454f"

            // Animation bei Wechsel
            Behavior on width {
                NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + wsRect.wsId)
            }
        }
    }
}