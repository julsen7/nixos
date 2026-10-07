pragma Singleton

import QtQuick

QtObject {
    property string currentWallpaper: "file:///home/julsen/wallpaper/Triangles.jpg"
    property bool isLocked: false
    property bool isSettingsOpen: true

    // SETTINGS
    property int settingsTab: 0
    property bool wifiEnabled: true
    property bool bluetoothEnabled: true
}