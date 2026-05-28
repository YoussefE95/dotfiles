import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell.Wayland

Rectangle {
	id: root
	required property LockContext context
	readonly property ColorGroup colors: Window.active ? palette.active : palette.inactive

	color: colors.window

	Label {
		id: clock

		anchors {
			top: parent.top
		}
        Text {
            font {
                family: Theme.fontFamily
                weight: Theme.fontWeight
                pointSize: 64
            }
            color: Theme.foreground
            text: `${DateTime.date}\n${DateTime.time}`
        }
	}

	ColumnLayout {
		// Uncommenting this will make the password entry invisible except on the active monitor.
		// visible: Window.active

		anchors {
			horizontalCenter: parent.horizontalCenter
			top: parent.verticalCenter
		}

		RowLayout {
			TextField {
				id: passwordBox

				implicitWidth: 250
				padding: 10

				focus: true
				enabled: !root.context.unlockInProgress
				echoMode: TextInput.Password
				inputMethodHints: Qt.ImhSensitiveData

				// Update the text in the context when the text in the box changes.
                onTextChanged: root.context.currentText = this.text;

				// Try to unlock when enter is pressed.
				onAccepted: root.context.tryUnlock();

				// Update the text in the box to match the text in the context.
				// This makes sure multiple monitors have the same text.
				Connections {
					target: root.context

					function onCurrentTextChanged() {
						passwordBox.text = root.context.currentText;
					}
				}
			}
		}

		Label {
			visible: root.context.showFailure
			text: "Incorrect password"
		}
	}
}
