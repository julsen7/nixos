import QtQuick
import QtQuick.Layouts
import Quickshell

import "./../"
import "./../components/custom"
import "./../components/topbarWidgets"
import "./../services"

Rectangle {
  id: root

  anchors.top: parent.top

  readonly property int collapsedWidth: 140
  readonly property int collapsedHeight: 40
  readonly property int padding: 40

  implicitWidth: hoverHandler.hovered ? (contentLayout.implicitWidth + padding) : collapsedWidth
  implicitHeight: hoverHandler.hovered ? (contentLayout.implicitHeight + padding) : collapsedHeight

  color: Theme.bg
  bottomLeftRadius: 20
  bottomRightRadius: 20

  Behavior on implicitWidth { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }
  Behavior on implicitHeight { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }

  HoverHandler {
    id: hoverHandler
    margin: root.height
  }

  CustomText {
    text: DateTimeService.time
    font.pixelSize: 20
    font.bold: true

    anchors.centerIn: parent

    opacity: hoverHandler.hovered ? 0 : 1
    visible: opacity > 0

    Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }
  }

  RowLayout {
    id: contentLayout

    anchors.centerIn: parent

    spacing: 30

    opacity: hoverHandler.hovered ? 1 : 0
    visible: opacity > 0

    Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutCubic } }

    MediaWidget { }

    CalenderWidget { }

    WeatherWidget { }
  }
}