import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Wayland

BarWidget {
    width: 32
    iconColor: Theme.magenta
    icon:""
    text: ""

    LauncherPopup {
        id: popupLoader
    }

    MouseArea {
        anchors.fill: parent
        onClicked: (mouse) => { popupLoader.load() }
    }

    LockContext {
        id: lockContext

        onUnlocked: {
            lock.locked = false;
        }
    }

    WlSessionLock {
        id: lock

        locked: false

        WlSessionLockSurface {
            LockSurface {
                anchors.fill: parent
                context: lockContext
            }
        }
    }

    IpcHandler {
        target: "popupLoader"

        function loadLauncher() {
            popupLoader.load()
        }

        function setTheme () {
            Theme.setTheme()
        }

        function lock() {
            lock.locked = true
        }
    }
}
