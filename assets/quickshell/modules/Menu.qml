import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

import "./../"
import "./../components"
import "./../components/custom"

PanelWindow {
    id: root

    anchors.bottom: true
    exclusionMode: ExclusionMode.Ignore

    implicitWidth: 600
    implicitHeight: hoverHandler.hovered ? 600 : 0
    color: "transparent"

    Behavior on implicitHeight { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }

    HoverHandler {
        id: hoverHandler
    }

    Rectangle {
        anchors.fill: parent

        color: Theme.bg
        topLeftRadius: 20
        topRightRadius: 20

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 15

            ListView {
                id: appList

                Layout.fillWidth: true
                Layout.fillHeight: true

                clip: true
                spacing: 10

                model: DesktopEntries.applications.values

                delegate: CustomListViewElement {
                    imageSource: Quickshell.iconPath(icon)
                    titleText: name ?? ""
                    contentText: (comment || genericName || name) ?? ""

                    implicitWidth: appList.width
                    implicitHeight: 68

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (runInTerminal) {
                                let termCommand = ["kitty", "-e"].concat(command)
                                Quickshell.execDetached(termCommand)
                            } else {
                                execute()
                            }
                        }
                    }
                }

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded
                }
            }

            CustomTextField {
                leftIcon: ""
                pixelSize: 18
                placeholderText: 'Type ">" for commands'
                color: Theme.bg2

                Layout.fillWidth: true
            }
        }
    }
}