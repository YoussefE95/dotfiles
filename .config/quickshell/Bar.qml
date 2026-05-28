import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: topBar

            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 42
            color: "transparent"//Theme.background

            Row {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }
                leftPadding: 16
                spacing: 6
                LauncherWidget {}
                //ThemeSetterWidget {}
                DateTimeWidget {}
            }
            WorkspacesWidget {
                anchors {
                    verticalCenter: parent.verticalCenter
                    centerIn: parent
                }
            }
            Row {
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                }
                rightPadding: 16
                spacing: 6
                BatteryWidget {}
                BrightnessWidget {}
                VolumeWidget {}
                NetworkWidget {}
                SystemTrayWidget {}
                PowerMenuWidget {}
            }
        }
    }
}
