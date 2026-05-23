pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string layer: "base"
    readonly property string layerFile: "/tmp/kanata_layer"

    function _apply(raw) {
        const v = (raw || "").trim()
        console.log("[KanataLayer] read:", JSON.stringify(v))
        if (v.length > 0 && v !== root.layer) root.layer = v
    }

    FileView {
        id: file
        path: root.layerFile
        watchChanges: true
        onFileChanged: reload()
        onLoaded: root._apply(file.text())
        onLoadFailed: (err) => console.log("[KanataLayer] load failed:", err)
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: file.reload()
    }

    Component.onCompleted: {
        console.log("[KanataLayer] singleton instantiated, watching", root.layerFile)
        file.reload()
    }
}
