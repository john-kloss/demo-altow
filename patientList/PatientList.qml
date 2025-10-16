import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.lottieqt 

// background of patient record view
Rectangle {
    id: listViewBackground
    width: parent.width
    height: parent.height

    color: "whitesmoke"

    Behavior on x {
        NumberAnimation {
            duration: 500
            easing.type: Easing.Linear
        }
    }

    RowLayout {
        id: top
        anchors.bottomMargin: 30
        width: parent.width - 150
        height: 100
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text: "Liste der Patienten"
            font.pixelSize: 30
            font.bold: true
            Layout.fillWidth: true
        }
        Button {
            text: "Neuer Eintrag"
            font.pixelSize: 25
            icon.source: "qrc:/resources/add.svg"
            icon.color: "white"
            onClicked: {
                patientList.model.append({"name":"-", "status":"Geplant", "age":5})
                successAnimation.start()
            }
            Material.roundedScale: Material.ExtraSmallScale
            Material.background: Material.color(Material.DeepPurple)
            Material.foreground: "white"

            Item {
                anchors.centerIn: parent
                z: parent.z + 1
                transform: Scale { xScale: 0.1; yScale: 0.1}
                LottieAnimation {
                    id: successAnimation
                    loops: 1
                    anchors.centerIn: parent
                    quality: LottieAnimation.MediumQuality
                    source: "qrc:/resources/success.json"
                    autoPlay: false
                }
            }
        }
    }

    // list view for patient records
    ListView {
        id: patientList
        height: parent.height - 60
        width: parent.width - 150
        anchors.top: top.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        model: PatientModel {}
        spacing: 10

        add: Transition {
            NumberAnimation { property: "height"; from: 0; to: 100; duration: 400 }
        }
        remove: Transition {
            NumberAnimation { property: "height"; from: 100; to: 0; duration: 400 }
        }
        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.OutBounce }
        }

        // header
        headerPositioning: ListView.OverlayHeader
        header: Rectangle {
            width: patientList.width
            height: 50
            radius: 5
            color: "transparent"
            RowLayout {
                width: parent.width
                height: parent.height
                uniformCellSizes: true
                Text {
                    text: "Name"
                    Layout.alignment: Qt.AlignHCenter
                    font.pixelSize: 25
                }
                Text {
                    text: "Alter"
                    Layout.alignment: Qt.AlignHCenter
                    font.pixelSize: 25
                }
                Text {
                    text: "Status"
                    Layout.alignment: Qt.AlignHCenter
                    font.pixelSize: 25
                }
                Text {text: ""}
            }
        }

        // handle pull to refresh
        states: [
            State {
                id: downRefresh
                name: "downRefresh"; when: (patientList.contentHeight > 0) &&
                    (patientList.contentY < -patientList.headerItem.height)
                StateChangeScript {
                    name: "funDownRefresh"
                    script: {
                        loadingAnimation.start();
                        patientList.model.append({"name": "Mattheo Arndt", "age": 4, "status": "Geplant"})
                    }
                }
            }
        ]
        Item {
            anchors.centerIn: parent
            transform: Scale { xScale: 0.3; yScale: 0.3}
            LottieAnimation {
                id: loadingAnimation
                loops: 2
                anchors.centerIn: parent
                quality: LottieAnimation.MediumQuality
                source: "qrc:/resources/loading.json"
                autoPlay: false
            }
            LottieAnimation {
                id: uploadAnimation
                loops: 1
                // visible: status == LottieAnimation.Ready ? false: true
                onStatusChanged: {
                    if (status === LottieAnimation.Ready) {
                        visible = false;
                    }
                }
                onFinished: {
                    visible = false;
                }
                anchors.centerIn: parent
                quality: LottieAnimation.MediumQuality
                source: "qrc:/resources/upload.json"
                autoPlay: false
            }
        }
        delegate: PatientDelegate {}

    }
}
