import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import Quickshell

import "./../"
import "./../components"
import "./../components/custom"

PanelWindow {
    id: root

    signal requestWallpaperChange(url newWallpaperUrl)

    property bool appMode: customTextField.text !== ">"
    property var entries: DesktopEntries.applications.values
    
    property bool shortcutOpen: false
    property bool isOpen: hoverHandler.hovered || shortcutOpen

    FolderListModel {
        id: wallpaperModel
        folder: "file:///home/julsen/wallpaper"
        nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp"]
        showDirs: false
    }

    anchors.bottom: true
    exclusionMode: ExclusionMode.Ignore

    focusable: true

    implicitWidth: appMode ? 600 : 1600
    implicitHeight: isOpen ? (appMode ? 600 : 250) : 1
    color: "transparent"

    Behavior on implicitHeight { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }

    Keys.onEscapePressed: root.shortcutOpen = false

    HoverHandler {
        id: hoverHandler
    }

    Rectangle {
        anchors.fill: parent

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

                model: entries.sort((a, b) => (a.name ?? "").toLowerCase().localeCompare((b.name ?? "").toLowerCase()))

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
                            root.shortcutOpen = false
                            
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
                    contentItem: Rectangle {
                        implicitWidth: 6
                        radius: width / 2
                        color: Theme.accent
                    }
                }
            }

            // WallpaperContent
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
                        console.log("Neues Wallpaper im Menü gewählt:", currentItem.wallpaperUrl)
                        root.requestWallpaperChange(currentItem.wallpaperUrl)
                    }
                }
            }

            CustomTextField {
                id: customTextField
                leftIcon: ""
                placeholderText: 'Type ">" for commands'
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