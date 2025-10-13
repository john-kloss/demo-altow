import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material 
import Qt.labs.lottieqt 

ToolBar {
    function startScan() {
        scanAnimation.start()
        scanAnimation.visible = true
        scannerStatus.text = "Scannt"
    }
    function stopScan() {
        scanAnimation.stop()
        scanAnimation.visible = false
        scannerStatus.text = "Bereit"
    }
    RowLayout {
        anchors.fill: parent
        Label {
            id: scannerStatus
            text: "Bereit"
            font.pixelSize: 20
            padding: 10
        }
        Item {
            transform: Scale { xScale: 0.04; yScale: 0.04}
            LottieAnimation {
                id: scanAnimation
                visible: false
                loops: LottieAnimation.Infinite
                anchors.verticalCenter: parent.verticalCenter
                quality: LottieAnimation.MediumQuality
                source: "qrc:/resources/play.json"
                autoPlay: false
            }
        }
        Label {
            text: "Patient"
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            Layout.fillWidth: true
        }
        ToolButton {
            icon.source: "qrc:/resources/settings.svg"
            onClicked: menu.open()
        }
    }
}
