import QtQuick
import QtQuick.Controls.Material 

ApplicationWindow {
    visibility: Window.Maximized
    visible: true
    title: qsTr("Demo Altow ScanUI")
    Material.theme: Material.Light
 
    PatientList {
        id: patientListView
    }

    ScanView {
        id: scanView
    }

    footer: StatusBar {
        id: toolBar
    }
}
