import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: background
    width: patientList.width
    height: 100
    color: "white"
    radius: 5
    border.color: "grey"

    required property int index
    required property string name
    required property int age
    required property string status

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onContainsMouseChanged: (mouse) => { background.color = containsMouse ? "lemonchiffon" : "white" }
        RowLayout {
            width: parent.width
            height: parent.height
            uniformCellSizes: true
            TextEdit {
                text: name
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 20
            }
            Text {
                text: age + " Monate" 
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 20
            }
            Rectangle {
                color: status === "Geplant" ? Material.color(Material.Cyan) :
                    Material.color(Material.LightGreen) 
                radius: 3
                width: childrenRect.width
                height: childrenRect.height
                Layout.alignment: Qt.AlignHCenter
                Text {
                    text: status
                    padding: 10
                    font.pixelSize: 20
                }
            }
            Row {
                Layout.alignment: Qt.AlignHCenter
                Button {
                    icon.name: "edit-delete"
                    onClicked: patientList.model.removePatient(index) 
                    flat: true
                }
                Button {
                    icon.source: "qrc:/resources/upload.svg"
                    onClicked: {
                        uploadAnimation.visible = true
                        uploadAnimation.start()
                    }
                    flat: true
                }
                Button {
                    icon.source: "qrc:/resources/add-image.svg"
                    onClicked: {
                        patientListView.x = -patientListView.width
                        scanView.x = 0
                    }
                    flat: true
                }
            }
        }
    }
}
