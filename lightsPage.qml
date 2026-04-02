import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    title: "Lights"
    background: Rectangle { color: "#E0E0E0" }

    property var roomModel

    Component {
        id: lightDelegate

        Rectangle {
            width: 450
            height: 280
            x: (GridView.view.cellWidth - width) / 2
            y: (GridView.view.cellHeight - height) / 2
            radius: 10
            color: "#FFFFFF"

            ColumnLayout {
                anchors { fill: parent; margins: 24 }
                spacing: 16

                // Room name + toggle
                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: name
                        font.pixelSize: 22
                        font.bold: true
                        color: "#1A1A1A"
                        Layout.fillWidth: true
                    }

                    Switch {
                        checked: lightOn
                        onClicked: lightOn = !lightOn
                    }
                }

                // Brightness label + value
                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: qsTr("Brightness")
                        font.pixelSize: 14
                        color: "#9E9E9E"
                        Layout.fillWidth: true
                    }

                    Text {
                        text: intensity + " %"
                        font.pixelSize: 14
                        font.bold: true
                        color: "#1A1A1A"
                    }
                }

                Slider {
                    Layout.fillWidth: true
                    from: 0
                    to: 100
                    stepSize: 1
                    value: intensity
                    enabled: lightOn
                    opacity: lightOn ? 1.0 : 0.4
                    onValueChanged: intensity = value
                }
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 16

        Text {
            text: qsTr("LIGHTS")
            font.bold: true
            font.pixelSize: 22
            color: "#1A1A1A"
            Layout.alignment: Qt.AlignRight
        }

        GridView {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: cellWidth * 2
            Layout.preferredHeight: cellHeight * 2
            width: cellWidth * 2
            height: cellHeight * 2
            model: roomModel
            delegate: lightDelegate
            cellWidth: 490
            cellHeight: 320
            interactive: false
        }
    }
}
