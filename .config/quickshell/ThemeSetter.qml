import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

Scope {
    id: root

    property bool isWindowOpen: false
    property list<string> supported
    property list<int> hover
    property string theme
    property string mode
    property string tone

    function themes() {
        const result = []

        for (const s of supported) {
            const split = s.split(' ')

            if (!result.includes(split[0])) {
                let selected = false

                if (split[0] == root.theme) {
                    selected = true
                }

                if (!result.some(t => t.theme === split[0])) {
                    result.push({ theme: split[0], hover: false, selected })
                }
            }
        }

        if (hover[0] === 0) {
            result[hover[1]].hover = true
        }

        return result
    }

    function modes() {
        const result = []

        for (const s of supported) {
            const split = s.split(' ')

            if (split[0] == root.theme) {
                let selected = false

                if (split[1] == root.mode) {
                    selected = true
                }

                const mode = { mode: split[1], hover: false, selected }

                if (!result.some(m => m.mode === split[1])) {
                    result.push(mode)
                }
            }
        }

        if (hover[0] === 1) {
            result[hover[1]].hover = true
        }

        return result
    }

    function tones() {
        const mode = modes()
        const result = []

        for (const s of supported) {
            const split = s.split(' ')

            if (split[0] == root.theme) {
                if (split[1] == root.mode) {
                    let selected = false

                    if (split[2] == root.tone) {
                        selected = true
                    }

                    const tone = { tone: split[2], selected }

                    if (!result.some(t => t.tone === split[2])) {
                        result.push(tone)
                    }
                }
            }
        }

        if (hover[0] === 2) {
            result[hover[1]].hover = true
        }

        return result
    }

    function getValues(item) {
        const values = {}

        if (item.hover) {
            values.color = Theme.orange
            values.fontWeight = 800
        } else if (item.selected) {
            values.color = Theme.green
            values.fontWeight = 800
        } else {
            values.color = Theme.foreground
            values.fontWeight = Theme.fontWeight
        }

        return values
    }

    FloatingWindow {
        id: themeSetter
        title: "Theme Setter"
        visible: root.isWindowOpen
        width: 550
        height: 400

        color: Theme.background

        Column {
            anchors.centerIn: parent
            spacing: 10

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Repeater {
                    model: themes()

                    Column {
                        Text {
                            font {
                                family: Theme.fontFamily
                                weight: getValues(modelData).fontWeight
                                pointSize: Theme.iconSize
                            }
                            text: modelData.theme
                            color: getValues(modelData).color
                        }
                    }
                }
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Repeater {
                    model: modes()

                    Column {
                        Text {
                            font {
                                family: Theme.fontFamily
                                weight: getValues(modelData).fontWeight
                                pointSize: Theme.iconSize
                            }
                            text: modelData.mode
                            color: getValues(modelData).color
                        }
                    }
                }
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Repeater {
                    model: tones()

                    Column {
                        Text {
                            font {
                                family: Theme.fontFamily
                                weight: getValues(modelData).fontWeight
                                pointSize: Theme.iconSize
                            }
                            text: modelData.tone
                            color: getValues(modelData).color
                        }
                    }
                }
            }
        }

        Shortcut {
            sequence: "h"
            onActivated: {
                if (root.hover[1] > 0) {
                    root.hover[1]--
                }
            }
        }

        Shortcut {
            sequence: "l"
            onActivated: {
                let length = 0

                if(root.hover[0] === 0) {
                    length = themes().length
                } else if (root.hover[0] === 1) {
                    length = modes().length
                } else if (root.hover[0] === 2) {
                    length = tones().length
                }

                if (root.hover[1] < length) {
                    root.hover[1]++
                }
            }
        }

        Shortcut {
            sequence: "j"
            onActivated: {
                if (root.hover[0] < 2) {
                    let length = 0

                    if (root.hover[0]+1 === 0) {
                        length = themes().length
                    } else if (root.hover[0]+1 === 1) {
                        length = modes().length
                    } else if (root.hover[0]+1 === 2) {
                        length = tones().length
                    }

                    if (root.hover[1] > length-1) {
                        root.hover[1] = length-1
                    }

                    root.hover[0]++
                }
            }
        }

        Shortcut {
            sequence: "k"
            onActivated: {
                if (root.hover[0] > 0) {
                    let length = 0

                    if (root.hover[0]-1 === 0) {
                        length = themes().length
                    } else if (root.hover[0]-1 === 1) {
                        length = modes().length
                    } else if (root.hover[0]-1 === 2) {
                        length = tones().length
                    }

                    if (root.hover[1] > length-1) {
                        root.hover[1] = length-1
                    }

                    root.hover[0]--
                }
            }
        }

        Shortcut {
            sequence: "q"
            onActivated: {
                root.isWindowOpen = false
            }
        }

        Shortcut {
            sequence: "space"
            onActivated: {
                if (root.hover[0] === 0) {
                    root.theme = themes()[root.hover[1]].theme
                } else if (root.hover[0] === 1) {
                    root.mode = modes()[root.hover[1]].mode
                } else if (root.hover[0] === 2) {
                    root.tone = tones()[root.hover[1]].tone
                }
            }
        }

        Shortcut {
            sequence: "Return"
            onActivated: {
                const cmd = `set-theme ${root.theme} ${root.mode} ${root.tone}`
                themeProc.command = [ "sh", "-c", cmd ]
                themeProc.running = true
                root.isWindowOpen = false
            }
        }
    }

    Process {
        id: themeProc
        command: ["sh", "-c", "get-theme --supported"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: () => {
                const supported = []

                for (const line of this.text.split('\n')) {
                    const split = line.split(' ')

                    if (split[0] == 'Current:'){
                        root.theme = split[1]
                        root.mode = split[2]
                        root.tone = split[3]
                    } else if (split[0] != '') {
                        supported.push(line)
                    }
                }

                root.supported = supported
                root.hover = [0, 0]
            }
        }
    }

    IpcHandler {
        target: "ThemeSetter"

        function toggle() {
            root.isWindowOpen = !root.isWindowOpen

            if (root.isWindowOpen) {
                themeProc.command = ["sh", "-c", "get-theme --supported"]
                themeProc.running = true
            }
        }
    }
}
