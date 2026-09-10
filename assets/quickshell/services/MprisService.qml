pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    readonly property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
    readonly property bool hasMedia: player !== null
    readonly property bool isPlaying: hasMedia && player.isPlaying

    readonly property string trackTitle: player.trackTitle || "No media :("
    readonly property string trackArtist: player.trackArtist || "Unknown artist"
    readonly property string artUrl: player.trackArtUrl || "https://media-fra3-1.cdn.whatsapp.net/v/t61.24694-24/417445320_1229505648014696_1766155250312417429_n.jpg?stp=dst-jpg_s96x96_tt6&ccb=11-4&oh=01_Q5Aa5gG5hFqHe7x52ed9LfSbh_8empnU529EtvEx3VK2InMmiw&oe=6AACDE1F&_nc_sid=5e03e0&_nc_cat=103"
}