import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Rectangle {
    id: root
    color: "#19120d" // Deine Material/Surface Farbe aus Dunst/Waybar
    radius: 15

    // Abstand zum Bildschirmschalter für Floating-Look
    anchors.margins: 5

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 15
        anchors.rightMargin: 15

        // Links: NixOS Icon
        Text {
            text: "󱄅"
            font.pixelSize: 18
            color: "#f0dfd7"
        }

        // Mitte: Workspaces
        Workspaces {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
        }

        // Rechts: System-Uhrzeit
        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }

        Text {
            text: Qt.formatDateTime(clock.date, "HH:mm")
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            font.bold: true
            color: "#f0dfd7"
        }
    }
}