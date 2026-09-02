import QtQuick
import Quickshell

Scope {
  Variants {
    model: Quickshell.screens

        PanelWindow {
            id: topBar

            required property var modelData
            screen: modelData

            implicitHeight: Math.max(33, island.implicitHeight)
            exclusiveZone: 40
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            SliderSettingsBar {
                id: sliderSettingsBar
                anchors.left: parent.left
            }

            DynamicIsland {
                id: island
                anchors.centerIn: parent
            }

            ControlCenterBar {
                id: controlCenterBar
                anchors.right: parent.right
            }
        }
    }
}