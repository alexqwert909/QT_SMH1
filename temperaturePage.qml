import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Page {
    title: "Temperature"
    background: Rectangle { color: "#E0E0E0" }

    property var roomModel

    Component {
        id: tempDelegate

        Rectangle {
            width: 450
            height: 280
            x: (GridView.view.cellWidth - width) / 2
            y: (GridView.view.cellHeight - height) / 2
            radius: 10
            color: "#FFFFFF"

            ColumnLayout {
                anchors { fill: parent; margins: 24 }
                spacing: 10

                // Room name + heating/cooling status
                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: name
                        font.pixelSize: 22
                        font.bold: true
                        color: "#1A1A1A"
                        Layout.fillWidth: true
                    }

                    Rectangle {
                        width: 32; height: 32
                        radius: 16
                        visible: temperature !== desiredTemp
                        color: temperature < desiredTemp ? "#FFCCBC" : "#BBDEFB"

                        Text {
                            anchors.centerIn: parent
                            text: temperature < desiredTemp ? "▲" : "▼"
                            font.pixelSize: 14
                            font.bold: true
                            color: temperature < desiredTemp ? "#E64A19" : "#1565C0"
                        }
                    }
                }

                // Current temperature
                Text {
                    text: temperature + " °C"
                    font.pixelSize: 42
                    font.bold: true
                    color: temperature < desiredTemp ? "#E64A19" :
                           temperature > desiredTemp ? "#1565C0" : "#1A1A1A"
                }

                // Set temperature label + value
                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: qsTr("set temperature")
                        font.pixelSize: 14
                        color: "#9E9E9E"
                        Layout.fillWidth: true
                    }

                    Text {
                        text: desiredTemp + " °C"
                        font.pixelSize: 14
                        font.bold: true
                        color: "#1A1A1A"
                    }
                }

                Slider {
                    Layout.fillWidth: true
                    from: 16
                    to: 30
                    stepSize: 1
                    value: desiredTemp
                    onValueChanged: desiredTemp = value
                }
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 16

        Text {
            text: qsTr("TEMPERATURE")
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
            delegate: tempDelegate
            cellWidth: 490
            cellHeight: 320
            interactive: false
        }
    }
}
