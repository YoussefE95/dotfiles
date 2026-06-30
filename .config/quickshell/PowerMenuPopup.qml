import Quickshell
import QtQuick

LazyLoader {
    id: popupLoader

    function load() {
        if (popupLoader.active) {
            popupLoader.active = false
        } else {
            popupLoader.loading = true
        }
    }

    PopupPanel {
        anchors.right: true
        width: info.width
        height: info.height

        PopupInfo {
            id: info
            infoWidth: 263
            infoHeight: 96
            borderColor: Theme.backgroundAlt
            Row {
                anchors.centerIn: parent
                spacing: 8
                PowerMenuButton {
                    icon: "󰍃"
                    command: "sh -c ~/.config/quickshell/scripts/quit.sh"
                }
                PowerMenuButton {
                    icon: ""
                    command: "reboot"
                }
                PowerMenuButton {
                    icon: ""
                    command: "poweroff"
                }
            }
        }
    }
}
