import QtQuick
import QtQuick.Controls

DropArea {
    id: dropArea
    required property int index
    required property string name
    required property int duration
    // enabled: !mouseArea.containsPress
    height: listView.height
    width: listView.height * 2
    onEntered: (drag) => {
        if (index != drag.source.index) {
            listView.model.move(index, drag.source.index, 1)
        }
    }

    MouseArea {
        id: mouseArea
        width: parent.width
        height: parent.height
        drag.target: tile
        drag.axis: Drag.XAxis
        cursorShape: containsPress ? Qt.DragMoveCursor : Qt.OpenHandCursor

        Rectangle {
            id: tile
            property int index: dropArea.index
            width: parent.width
            height: parent.height
            color: Material.color(Material.Amber)
            Drag.active: mouseArea.drag.active
            Drag.hotSpot.x: width / 2
            border.color: dropArea.containsDrag ? "red" : "white"
            radius: 5
            Text {
                text: duration + "''"
                padding: 10
            }
            Text {
                text: name
                anchors.centerIn: parent
                font.pixelSize: 20
            }
        }
    }
}
