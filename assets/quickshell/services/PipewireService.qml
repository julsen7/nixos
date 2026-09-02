pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

Singleton {
    id: root

    property list<PwNode> sinks: []
    property list<PwNode> sources: []
    property list<PwNode> streams: []
}