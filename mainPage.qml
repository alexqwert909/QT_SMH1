import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    title: "Rooms"
    background: Rectangle { color: "#E0E0E0" }

    property var roomModel

    function tempColor(t) {
        if (t < 18) return "#90CAF9"
        if (t < 22) return "#A5D6A7"
        if (t < 25) return "#FFE082"
        return "#EF9A9A"
    }

    Component {
        id: nameDelegate

        Rectangle {
            width: 450
            height: 280
            x: (GridView.view.cellWidth - width) / 2
            y: (GridView.view.cellHeight - height) / 2
            radius: 10
            color: "#FFFFFF"

            ColumnLayout {
                anchors { fill: parent; margins: 24 }
                spacing: 12

                // Room name + light toggle
                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: name
                        font.pixelSize: 20
                        font.bold: true
                        color: "#1A1A1A"
                        Layout.fillWidth: true
                    }

                    Rectangle {
                        width: 48; height: 48
                        radius: 24
                        color: lightOn ? "#FFC107" : "#BDBDBD"

                        Image {
                            anchors.fill: parent
                            source: "images/light_bulb.svg"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: lightOn = !lightOn
                        }
                    }
                }

                // Temperature bar + value + stats
                RowLayout {
                    spacing: 16
                    Layout.fillWidth: true

                    Rectangle {
                        width: 10
                        Layout.fillHeight: true
                        radius: 5
                        color: tempColor(temperature)
                    }

                    ColumnLayout {
                        spacing: 4

                        Text {
                            text: temperature.toFixed(1) + " °C"
                            font.pixelSize: 42
                            font.bold: true
                            color: "#1A1A1A"
                        }

                        RowLayout {
                            spacing: 20

                            ColumnLayout {
                                spacing: 2
                                Text { text: "Humidity";  font.pixelSize: 11; color: "#9E9E9E" }
                                Text { text: humidity + " %"; font.pixelSize: 16; font.bold: true; color: "#424242" }
                            }

                            ColumnLayout {
                                spacing: 2
                                Text { text: "CO₂";      font.pixelSize: 11; color: "#9E9E9E" }
                                Text { text: co2 + " ppm"; font.pixelSize: 16; font.bold: true; color: co2 > 600 ? "#E53935" : "#424242" }
                            }
                        }
                    }
                }
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 16

        Text {
            text: qsTr("SMART HOME")
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
            delegate: nameDelegate
            cellWidth: 490
            cellHeight: 320
            interactive: false
        }
    }
}
