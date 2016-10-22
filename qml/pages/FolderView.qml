import QtQuick 2.0
import Sailfish.Silica 1.0
import Qt.labs.folderlistmodel 2.1

Dialog {
  id: folderView
   ListView {
      anchors.fill: parent
      header:   DialogHeader {
          id: header
          title: qsTr("Select root folder")
      }

      FolderListModel {
          id: folderModel
          //nameFilters: ["*.mp3"]
      }

      Component {
          id: fileDelegate
          ListItem {
              Label {
                x: Theme.horizontalPageMargin
                text: fileName
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
              }
              onClicked: {folderModel.folder = folderModel.folder + "/" + fileName;
              console.log(folderModel.folder) }
          }
      }

      model: folderModel
      delegate: fileDelegate
  }
   onAccepted: {}
}

