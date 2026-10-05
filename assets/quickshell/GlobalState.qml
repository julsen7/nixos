pragma Singleton

import QtQuick

QtObject {
    property string currentWallpaper: "file:///home/julsen/wallpaper/Triangles.jpg"
    property bool isLocked: false
    property bool isSettingsOpen: true
    property int settingsTab: 0
}