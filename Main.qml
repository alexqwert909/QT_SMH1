import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SMH1

Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("Hello World")

    ListModel {
        id: sharedRoomModel

        ListElement { name: "Living room"; temperature: 23.1; humidity: 45; lightOn: true;  intensity: 0; motionDetected: true;  co2: 420; desiredTemp: 22 }
        ListElement { name: "Kitchen";     temperature: 24.5; humidity: 55; lightOn: false; intensity: 0; motionDetected: false; co2: 610; desiredTemp: 22 }
        ListElement { name: "Bedroom 1";   temperature: 19.2; humidity: 40; lightOn: false; intensity: 0; motionDetected: false; co2: 380; desiredTemp: 20 }
        ListElement { name: "Bedroom 2";   temperature: 21.0; humidity: 42; lightOn: false; intensity: 0; motionDetected: false; co2: 395; desiredTemp: 20 }
    }
    Instantiator {
        model: sharedRoomModel
        delegate: Thermostat {
            targetTemp: desiredTemp
            Component.onCompleted: currentTemp = Math.round(temperature)
            onCurrentTempChanged: sharedRoomModel.setProperty(index, "temperature", currentTemp)
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle{
            width: 220
            Layout.fillHeight: true
            color: "#E8EAF0"
            radius: 10

            Column {
                anchors.centerIn: parent
                spacing: 12
                width: 180

                // House icon
                Rectangle {
                    width: 120; height: 120
                    color: "#E8EAF0"
                    radius: 8
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: home
                        anchors.fill: parent
                        source: "images/home.svg"
                    }
                    Text {
                        anchors.centerIn: parent
                        text: "23°"
                        font.pixelSize: 28
                        font.bold: true
                        color: "black"
                    }
                }

                Item { width: 1; height: 20 }

                Button {
                    text: "Main"
                    font.pixelSize: 16
                    width: parent.width
                    onClicked: stack.replace("mainPage.qml", { roomModel: sharedRoomModel })
                }
                Button {
                    text: "Lights"
                    font.pixelSize: 16
                    width: parent.width
                    onClicked: stack.replace("lightsPage.qml", { roomModel: sharedRoomModel })
                }
                Button {
                    text: "Temperature"
                    font.pixelSize: 16
                    width: parent.width
                    onClicked: stack.replace("temperaturePage.qml", { roomModel: sharedRoomModel })
                }
                Button {
                    text: "Sensors"
                    font.pixelSize: 16
                    width: parent.width
                    onClicked: stack.replace("sensorPage.qml")
                }
                Button {
                    text: "Events"
                    font.pixelSize: 16
                    width: parent.width
                    onClicked: stack.replace(eventsView)
                }
            }
        }
        Rectangle{
            width: 1060
            Layout.fillHeight: true
            //color: "red"

            StackView {
                id: stack
                anchors.fill: parent
                Component.onCompleted: push("mainPage.qml", { roomModel: sharedRoomModel })

                Component {
                    id: eventsView
                    Text {
                        text: "EVENTS"
                    }
                }
            }
        }
    }

}
