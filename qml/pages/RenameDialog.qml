import QtQuick 2.0
import Sailfish.Silica 1.0
import Qt.labs.folderlistmodel 2.1

Dialog {
    id: renameView
    property string name: ""

    Column {
        width: parent.width
        DialogHeader {
          id: header
          title: qsTr("Rename")
        }

        TextField {
            id: nameField

            width: parent.width
            placeholderText: qsTr("Enter page name")
            label: qsTr("Page name")
            text: name
        }
    }

    onDone: if (result == DialogResult.Accepted) name = nameField.text
}

