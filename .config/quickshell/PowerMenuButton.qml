import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
    id: button
    property string icon
    property string command

    width: 74
    height: 74
    radius: 10
    color: Theme.backgroundAlt

    Process {
        id: buttonProc
        command: button.command.split(" ")
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: (mouse) => {
            buttonProc.running = true
        }
        onEntered: (mouse) => {
            button.color = Theme.orange
            buttonIcon.color = Theme.background
        }
        onExited: (mouse) => {
            button.color = Theme.backgroundAlt
            buttonIcon.color = Theme.foreground
        }
    }

    Text {
        id: buttonIcon
        anchors.centerIn: parent
        font {
            family: Theme.fontFamily
            weight: Theme.fontWeight
            pointSize: 28
        }
        color: Theme.foreground
        text: button.icon
    }
}
