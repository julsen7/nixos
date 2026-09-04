pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    readonly property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
    readonly property bool hasMedia: player !== null
    readonly property bool isPlaying: hasMedia && player.isPlaying

    readonly property string trackTitle: hasMedia ? player.trackTitle : "No media"
    readonly property string trackArtist: hasMedia ? player.trackArtist : "Unknown"
    readonly property string artUrl: hasMedia ? player.trackArtUrl : ""
}