import QtQuick 2.0
import Sailfish.Silica 1.0
import Qt.labs.folderlistmodel 2.1
import org.netbug.player 1.0

import "functions.js" as FS

Dialog {
  id: folderView

  PlaylistEntry {
      id: bookEntry
  }

  ListView {
      anchors.fill: parent
      header:   DialogHeader {
          id: header
          title: qsTr("Select root folder")
      }

      FolderListModel {
          id: folderModel
          showDotAndDotDot: true
          showFiles: false
          //nameFilters: ["*.mp3"]
      }

      Component {
          id: fileDelegate
          ListItem {
              height: fileName == '.' ? 0 : implicitHeight
              Label {
                x: Theme.horizontalPageMargin
                text: fileName
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
              }
              onClicked: folderModel.folder = folderModel.folder + "/" + fileName;
          }
      }

      model: folderModel
      delegate: fileDelegate
  }
   onAccepted: {
       var path = folderModel.folder
//       console.log("Searching folder " + path)
       bookEntry.dataDir = path
       //~ checking the folder for being a book itself
       //var im = FS.checkImages(path, folderModel)
       //var m = FS.checkMusic(path, folderModel)
       console.log("Cover: " + bookEntry.coverImagePath + ', music: ' + bookEntry.playFiles)
   }
}

