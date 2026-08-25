import QtQuick
import Quickshell
import Quickshell.Hyprland

Scope {
    id: shortcuts
    
    property bool isOpen: false 

    GlobalShortcut {
        name: "applist"
        description: "View AppList"
        
        onPressed: {

            console.log("Shortcut gedrückt!");

            // shortcuts.isOpen = !shortcuts.isOpen;
            
            // if (shortcuts.isOpen) {
            //     shortcuts.requestActivate();
            // }
        }
    }
}
