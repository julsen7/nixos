import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

import "../"
import "../components"

Rectangle {
    id: root

    readonly property int padding: 40

    implicitWidth: controlCenterRow.implicitWidth + padding
    implicitHeight: 40

    color: Theme.bg
    bottomLeftRadius: height / 2

    HoverHandler {
        id: hoverHandler
        margin: root.height
    }

    y: hoverHandler.hovered || trayContextMenu.opened ? 0 : -height

    Behavior on y { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }

    // --- CUSTOM KONTEXTMENÜ FÜR TRAY ICONS ---
    Popup {
        id: trayContextMenu
        padding: 6
        modal: false
        focus: true
        closePolicy: Popup.CloseOnPressOutsideParent | Popup.CloseOnEscape

        property var activeMenu: null

        background: Rectangle {
            color: Theme.bg
            border.color: Theme.bg3
            border.width: 1
            radius: 12
        }

        contentItem: ColumnLayout {
            spacing: 2

            Repeater {
                model: trayContextMenu.activeMenu ? trayContextMenu.activeMenu.items : []

                delegate: Loader {
                    required property var modelData
                    visible: modelData ? (modelData.visible ?? true) : false
                    Layout.fillWidth: true

                    sourceComponent: (modelData && modelData.isSeparator) ? separatorComponent : menuItemComponent
                }
            }
        }

        Component {
            id: separatorComponent
            Rectangle {
                implicitWidth: 160
                implicitHeight: 1
                color: Theme.bg3
                Layout.topMargin: 4
                Layout.bottomMargin: 4
            }
        }

        Component {
            id: menuItemComponent
            Rectangle {
                id: itemRect
                implicitWidth: Math.max(160, itemRow.implicitWidth + 20)
                implicitHeight: 30
                radius: 6
                color: itemHover.hovered ? Theme.bg3 : "transparent"
                enabled: modelData ? (modelData.enabled ?? true) : true
                opacity: enabled ? 1.0 : 0.5

                RowLayout {
                    id: itemRow
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 8

                    CustomText {
                        // Entfernt Tastatur-Shortcuts-Zeichen (&Open -> Open)
                        text: modelData ? (modelData.label || "").replace(/&/g, "") : ""
                        color: itemHover.hovered ? Theme.accent : Theme.fg
                        font.pixelSize: 13
                        Layout.fillWidth: true
                    }
                }

                HoverHandler { 
                    id: itemHover
                    cursorShape: parent.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor 
                }
                
                TapHandler {
                    enabled: parent.enabled
                    onTapped: {
                        if (modelData && typeof modelData.trigger === "function") {
                            modelData.trigger() // Führt die DBus-Aktion (z.B. App öffnen) aus
                        }
                        trayContextMenu.close()
                    }
                }
            }
        }
    }

    RowLayout {
        id: controlCenterRow
        anchors.fill: parent
        anchors.leftMargin: padding / 2
        anchors.rightMargin: padding / 2
        spacing: 20

        // --- SYSTEM TRAY ---
        RowLayout {
            spacing: 10
            Repeater {
                model: SystemTray.items
                CustomImage {
                    id: trayIcon
                    required property SystemTrayItem modelData
                    source: modelData.icon
                    implicitWidth: 20
                    implicitHeight: 20

                    HoverHandler { 
                        id: trayHover
                        cursorShape: Qt.PointingHandCursor 
                    }

                    TapHandler {
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        onTapped: (eventPoint, button) => {
                            let x = eventPoint.scenePosition.x
                            let y = eventPoint.scenePosition.y

                            if (button === Qt.RightButton) {
                                if (modelData.menu) {
                                    trayContextMenu.activeMenu = modelData.menu
                                    // Platziert das Popup direkt unter dem geklickten Icon
                                    trayContextMenu.x = trayIcon.mapToItem(root, 0, trayIcon.height + 5).x
                                    trayContextMenu.y = trayIcon.mapToItem(root, 0, trayIcon.height + 5).y
                                    trayContextMenu.open()
                                }
                            } else if (button === Qt.MiddleButton) {
                                modelData.secondaryActivate(x, y)
                            } else {
                                modelData.activate(x, y)
                            }
                        }
                    }
                }
            }
        }

        // --- BLUETOOTH ---
        CustomTopSetting {
            icon: "󰂯"
            command: "bluetoothctl devices connected | wc -l"
            interval: 10000

            HoverHandler { id: btHover; cursorShape: Qt.PointingHandCursor }
            TapHandler {
                onTapped: {
                    GlobalState.settingsTab = 0
                    GlobalState.isSettingsOpen = true
                }
            }
        }

        // --- NETWORK ---
        CustomTopSetting {
            command: "nmcli -t -f TYPE,NAME connection show --active | head -n1 | awk -F: 'BEGIN{i=\"\"; v=\"Keine Verbindung\"} {if($1 ~ \"ethernet\"){i=\"󰌗\"; v=\"LAN\"} else if($1 ~ \"wireless\"){i=\"\"; v=$2}} END{print i\"\\t\"v}'"
            interval: 10000

            property string networkBandwidth: " 0 KB/s    0 KB/s"

            HoverHandler { id: netHover; cursorShape: Qt.PointingHandCursor }
            TapHandler {
                onTapped: {
                    GlobalState.settingsTab = 2
                    GlobalState.isSettingsOpen = true
                }
            }
        }

        // --- BATTERY ---
        CustomTopSetting {
            command: "cat /sys/class/power_supply/BAT1/capacity" 
            interval: 30000
            
            HoverHandler { id: batHover; cursorShape: Qt.ArrowCursor }
            TapHandler {
                onTapped: {
                    GlobalState.settingsTab = 3
                    GlobalState.isSettingsOpen = true
                }
            }

            onValueChanged: {
                let c = parseInt(value);
                if (c < 20) icon = "";
                else if (c < 40) icon = "";
                else if (c < 60) icon = "";
                else if (c < 80) icon = "";
                else icon = "";
                
                value = c + "%";
            }
        }

        CustomText {
            text: ""
            font.pixelSize: 22
            color: powerHover.hovered ? Theme.red : Theme.fg

            HoverHandler { id: powerHover; cursorShape: Qt.PointingHandCursor }
            TapHandler { onTapped: GlobalState.isLocked = true }
        }
    }
}