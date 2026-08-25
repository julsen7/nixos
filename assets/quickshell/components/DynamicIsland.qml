import QtQuick
import Quickshell
import QtQuick.Effects
import QtQuick.Layouts

import "./../services"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: dynamicIsland

      required property var modelData
      screen: modelData

      anchors {
        top: true
      }

      implicitWidth: 500
      implicitHeight: 120
      color: "transparent"
      margins { 
        top: 12
      }

      Rectangle {
        id: extendedBubble

        anchors.fill: parent
        radius: 28
        color: "#0b0b0b"

        RowLayout {
          id: extendedIsland

          anchors.fill: parent

          RowLayout {
            id: currentMedia

            spacing: 20

            Rectangle {
              id: albumCover

              Layout.preferredWidth: 64
              Layout.preferredHeight: 64
              radius: 18
              color: "#202020"
            }

            ColumnLayout {
              id: mediaMeta

              Text {
                id: title

                text: "Title"
                color: "white"
                font.pixelSize: 18
              }

              Text {
                id: interpret

                text: "Interpret"
                color: "#8A8A8A"
                font.pixelSize: 14
              }

              RowLayout {
                id: controls

                spacing: 10
                
                Text { text: "⏮"; color: "white"; font.pixelSize: 18 }
                Text { text: "▶"; color: "white"; font.pixelSize: 18 }
                Text { text: "⏭"; color: "white"; font.pixelSize: 18 }
              }
            }
          }

          ColumnLayout {
            Layout.preferredWidth: 160

            Text {
              text: Time.time
              color: "white"
              font.pixelSize: 32
              font.bold: true
            }

            RowLayout {
              spacing: 8
              Text { text: "W\n12"; color: "#444444"; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 12 }
              Text { text: "THU\n13"; color: "#55E0D0"; font.bold: true; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 12 }
              Text { text: "F\n14"; color: "#444444"; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 12 }
            }
          }
        }
      }
    }
  }
}