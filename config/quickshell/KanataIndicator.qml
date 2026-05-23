import QtQuick
import qs.services
import qs.modules.common
import qs.modules.common.widgets

Rectangle {
    id: root
    property bool vertical: false
    property color tint: Appearance.colors.colOnSurfaceVariant

    readonly property var palette: ({
        "base":           { label: "base",    color: "#888888" },
        "pentest":        { label: "PENTEST", color: "#ff9900" },
        "pentest-locked": { label: "PENTEST*",color: "#ff9900" },
        "sqli":           { label: "SQLi",    color: "#ff4d4d" },
        "trav":           { label: "TRAV",    color: "#ff4d4d" },
        "ssrf":           { label: "SSRF",    color: "#ff4d4d" },
        "xss":            { label: "XSS",     color: "#ff4d4d" },
        "creds":          { label: "CREDS",   color: "#00bcd4" },
    })

    readonly property var entry: palette[KanataLayer.layer] ?? ({ label: KanataLayer.layer, color: root.tint })

    color: "transparent"
    radius: 4
    implicitWidth: vertical ? 24 : (label.implicitWidth + 16)
    implicitHeight: vertical ? (label.implicitHeight + 8) : 22

    Text {
        id: label
        anchors.centerIn: parent
        text: "⌨ " + root.entry.label
        color: root.entry.color
        font.pixelSize: 12
    }
}
