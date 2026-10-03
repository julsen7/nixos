import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import Quickshell

import "../"
import "../components"
import "../components/custom"

PanelWindow {
    id: root

    property bool appMode: !customTextField.text.startsWith(">")

    property var customApps: [{
        name: "Settings",
        genericName: "Control Center",
        comment: "Manage Audio, Bluetooth and Network",
        icon: "preferences-system",
        runInTerminal: false,
        execute: () => { GlobalState.isSettingsOpen = true }
    }]

    property var allEntries: customApps.concat(DesktopEntries.applications.values)

    property bool shortcutOpen: false
    property bool forceClosed: false

    property bool isOpen: (hoverHandler.hovered || shortcutOpen) && !forceClosed

    function getFilteredApps(entries, query) {
        let arr = entries;
        if (query && appMode) {
            let lowerQuery = query.toLowerCase();
            arr = arr.filter(app => 
                (app.name || "").toLowerCase().includes(lowerQuery) || 
                (app.genericName || "").toLowerCase().includes(lowerQuery)
            );
        }
        return arr.sort((a, b) => (a.name || "").toLowerCase().localeCompare((b.name || "").toLowerCase()));
    }

    FolderListModel {
        id: wallpaperModel
        folder: "file:///home/julsen/wallpaper"
        nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp"]
        showDirs: false
    }

    anchors.bottom: true
    exclusionMode: ExclusionMode.Ignore
    focusable: true

    implicitWidth: appMode ? 600 : Math.min(1600, (Quickshell.screens[0]?.width || 1920) - 40)
    implicitHeight: isOpen ? (appMode ? 600 : 250) : 8
    color: "transparent"

    Behavior on implicitWidth { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
    Behavior on implicitHeight { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

    Shortcut {
        sequence: "Escape"
        onActivated: {
            root.shortcutOpen = false
            customTextField.text = ""
        }
    }

    HoverHandler { 
        id: hoverHandler 
        onHoveredChanged: {
            if (!hovered) {
                root.forceClosed = false
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        clip: true

        opacity: root.isOpen ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 200 } }

        color: Theme.bg
        topLeftRadius: 20
        topRightRadius: 20

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 15

            // App Content
            ListView {
                id: appList

                visible: appMode
                Layout.fillWidth: true
                Layout.fillHeight: true

                clip: true
                spacing: 10

                model: getFilteredApps(root.allEntries, customTextField.text)

                delegate: CustomListViewElement {
                    property var app: modelData

                    imageSource: Quickshell.iconPath(app.icon || "")
                    titleText: app.name ?? ""
                    contentText: (app.comment || app.genericName || app.name) ?? ""

                    implicitWidth: appList.width
                    implicitHeight: 68

                    TapHandler {
                        onTapped: {
                            root.shortcutOpen = false
                            root.forceClosed = true
                            
                            if (app.runInTerminal) {
                                let termCommand = ["kitty", "-e"].concat(app.command)
                                Quickshell.execDetached(termCommand)
                            } else {
                                app.execute()
                            }
                            
                            customTextField.text = "" 
                        }
                    }
                }

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded
                    contentItem: Rectangle {
                        implicitWidth: 6
                        radius: width / 2
                        color: Theme.accent
                    }
                }
            }

            // Wallpaper content
            PathView {
                id: wallpaperList

                visible: !appMode
                Layout.fillWidth: true
                Layout.fillHeight: true

                model: wallpaperModel

                property int itemWidth: 200
                property int itemSpacing: 10
                property int totalItemWidth: itemWidth + itemSpacing

                pathItemCount: Math.ceil(width / totalItemWidth) + 4

                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5
                highlightMoveDuration: 250

                path: Path {
                    startX: (wallpaperList.width / 2) - ((wallpaperList.pathItemCount / 2) * wallpaperList.totalItemWidth)
                    startY: wallpaperList.height / 2

                    PathLine { 
                        x: (wallpaperList.width / 2) + ((wallpaperList.pathItemCount / 2) * wallpaperList.totalItemWidth)
                        y: wallpaperList.height / 2 
                    }
                }

                delegate: WallpaperItem {
                    wallpaperUrl: model.fileUrl

                    onItemClicked: (idx) => {
                        wallpaperList.currentIndex = idx
                    }
                }

                onCurrentItemChanged: {
                    if (currentItem && currentItem.wallpaperUrl !== "") {
                        GlobalState.currentWallpaper = currentItem.wallpaperUrl
                    }
                }
            }

            CustomTextField {
                id: customTextField
                leftIcon: ""
                placeholderText: appMode ? 'Type ">" for wallpapers' : 'Type to search...'
                color: Theme.bg2
                Layout.fillWidth: true

                onVisibleChanged: {
                    if (visible && root.shortcutOpen) {
                        forceActiveFocus()
                    }
                }
            }
        }
    }
}