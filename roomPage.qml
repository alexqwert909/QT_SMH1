import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Page {
    title: "Rooms"
    background: Rectangle { color: "#E0E0E0" }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 16

        RowLayout{
            Button{
                Layout.fillWidth: true
                font.pixelSize: 22
                Layout.alignment: Qt.AlignLeft
                text: "← Home"
                onClicked: stack.replace("mainPage.qml")
            }

            Text {
                font.bold: true
                text: qsTr("SMART HOME")
                font.pixelSize: 22
                color: "#1A1A1A"
                Layout.alignment: Qt.AlignRight
            }
        }
    }
}
