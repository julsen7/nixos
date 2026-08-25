import QtQuick
import Quickshell

PanelWindow {
    id: drawerWindow
    
    anchors {
        top: true
        bottom: true
        left: true
    }
    width: 350
    
    property bool isOpen: false 

    Rectangle {
        id: drawerBackground
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width
        color: "#1e1e2e"

        Behavior on x {
            XAnimator {
                duration: 250
                easing.type: Easing.OutCubic
            }
        }

        x: drawerWindow.isOpen ? 0 : -drawerBackground.width

        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15

            Text {
                text: "Anwendungen"
                color: "white"
                font.pointSize: 18
            }

            ListView {
                width: parent.width
                height: parent.height - 50
                model: ["Firefox", "Terminal", "File Manager", "Discord"] // Später dynamisch
                
                delegate: Rectangle {
                    width: parent.width
                    height: 45
                    color: "transparent"
                    
                    Text {
                        text: modelData
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            console.log("Starte: " + modelData);
                            drawerWindow.isOpen = false;
                        }
                    }
                }
            }
        }
    }
}
