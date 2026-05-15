pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: theme
    property string fontFamily: "JetBrains Mono"
    property int fontWeight: 500
    property int fontSize: 13
    property int iconSize: 16
    property color background
    property color backgroundAlt
    property color foreground
    property color gray
    property color red
    property color green
    property color yellow
    property color blue
    property color magenta
    property color cyan
    property color orange

    Process {
        id: themeProc
        command: ["sh", "-c", "get-theme --full-palette"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: () => {
                const split = this.text.split("\n")

                theme.background = "#" + split[0]
                theme.backgroundAlt = "#" + split[1]
                theme.foreground = "#" + split[2]
                theme.gray = "#" + split[3]
                theme.red = "#" + split[4]
                theme.green = "#" + split[5]
                theme.yellow = "#" + split[6]
                theme.blue = "#" + split[7]
                theme.magenta = "#" + split[8]
                theme.cyan = "#" + split[9]
                theme.orange = "#" + split[10]
            }
        }
    }

    function setTheme() {
        themeProc.running = true
    }
}
