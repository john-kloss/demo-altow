import QtQuick
import QtQuick.Controls
import Qt.labs.lottieqt 

// background of scan view
Rectangle {

    width: parent.width
    height: parent.height
    // x: parent.width

    color: "whitesmoke"

    Behavior on x {
        NumberAnimation {
            duration: 500
            easing.type: Easing.Linear
        }
    }

    Row {
        id: imageView
        width: parent.width
        Repeater {
            model: 3
            delegate: Rectangle {
                color: "grey"
                width: parent.width / 3
                height: parent.width / 3 
                border.color: "white"
            }
        }
    }

    Row {
        id: controls
        width: parent.width
        height: (parent.height - imageView.height) / 2
        anchors.top: imageView.bottom

        Button {
            icon.source:"qrc:/resources/back.svg"
            icon.width: height / 3
            icon.height: height / 3
            height: parent.height / 2
            width: height
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                patientListView.x = 0
                scanView.x = scanView.width
                isScanning = true
            }
        }
        Button {
            property bool isScanning: false
            icon.source:  isScanning ? "qrc:/resources/pause.svg" : "qrc:/resources/play.svg"
            icon.width: height / 3
            icon.height: height / 3
            height: parent.height/2
            width: height
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                if (isScanning) {
                    toolBar.stopScan()
                    isScanning = false
                
                } else {
                    toolBar.startScan()
                    isScanning = true
                }
            } 
        }
    }

    // list view for mr sequences
    ListView {
        id: listView
        anchors.top: controls.bottom
        width: parent.width
        height: (parent.height - imageView.height) / 2
            orientation: ListView.Horizontal
        model: 5
        delegate: Rectangle {
            height: listView.height
            width: listView.height * 2
            color: Material.color(Material.BlueGrey)
            border.color: "black"
        }
    }
}
