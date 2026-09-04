import QtQuick
import Quickshell
import Quickshell.Hyprland

Scope {
    id: root

    BottomMenu {
        id: myBottomMenu
    }

    GlobalShortcut {
        name: "menu"
        description: "Open menu"
        onPressed: myBottomMenu.shortcutOpen = !myBottomMenu.shortcutOpen;
    }
}