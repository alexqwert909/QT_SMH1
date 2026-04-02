import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    title: "Sensor"
    background: Rectangle { color: "#E0E0E0" }

    ListModel {
        id: sensorModel
        ListElement{name:"sensor1"; status: 1}
        ListElement{name:"sensor2"; status: 1}
    }

        Component{
            id:sensorDelegate
            Rectangle {
                width: 900
                height: 50
                radius: 10
                color: "#FFFFFF"
                ColumnLayout{
                    Text{
                        text:"sensor" + name
                        font.pixelSize: 24
                    }
                    Text{
                        text: status
                        font.pixelSize: 24
                    }
                }
            }
        }


    ColumnLayout {
        anchors.centerIn: parent
        spacing: 16

        Text {

            text: qsTr("Sensor")
            font.bold: true
            font.pixelSize: 22
            color: "#1A1A1A"
            Layout.alignment: Qt.AlignRight
        }
        ListView{
            Layout.alignment: Qt.AlignHCenter
            model: sensorModel
            delegate: sensorDelegate

        }
    }

}
