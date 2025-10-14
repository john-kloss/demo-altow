import QtQuick
import QtQuick.Controls
import Qt.labs.lottieqt 

// background of scan view
Rectangle {

    width: parent.width
    height: parent.height
    x: parent.width

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
                Image {
                    source: "qrc:/resources/head-"+ index+".jpg"
                    width: parent.width
                    height: parent.height
                    fillMode: Image.PreserveAspectCrop
                    clip: true
                }
            }
        }
    }

    // button controls
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
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: parent.width
        height: (parent.height - imageView.height) / 2
        orientation: ListView.Horizontal
        spacing: 10
        model: SequenceModel {}
        delegate: SequenceDelegate {}
    }
}
