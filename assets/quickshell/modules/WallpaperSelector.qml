// PanelWindow.qml
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

    anchors.bottom: true
    exclusionMode: ExclusionMode.Ignore

    focusable: true

    implicitWidth: 1600
    implicitHeight: hoverHandler.hovered ? 250 : 0
    color: "transparent"

    Behavior on implicitHeight { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }

    HoverHandler {
        id: hoverHandler
    }

    FolderListModel {
        id: wallpaperModel
        folder: "file:///home/julsen/wallpaper"
        nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp"]
        showDirs: false
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

            PathView {
                id: wallpaperList

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
                        console.log("Neues Wallpaper ausgewählt:", currentItem.wallpaperUrl)
                        Background.wallpaperPath = currentItem.wallpaperUrl
                    }
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