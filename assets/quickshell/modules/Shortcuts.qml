import QtQuick
import Quickshell
import Quickshell.Hyprland

Scope {
    id: shortcuts
    
    property bool isOpen: false 

    GlobalShortcut {
        name: "applist"

        onPressed: {
            console.log("Shortcut gedrückt!");
            // open Menu
        }
    }
}