import QtQuick 2.0
import Sailfish.Silica 1.0
import Qt.labs.folderlistmodel 2.1
import org.netbug.player 1.0
import "../service"

Dialog {
  id: folderView

  Dao {
      id: dao
  }

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
       var im = bookEntry.coverImagePath
       var m = bookEntry.playFiles
       var outpath = bookEntry.dataDir
       var bn = bookEntry.name
       console.log("Cover: " + im + ', music: ' + m)
       if (im.length > 0 && m.length > 0)
           dao.addBook(bn, outpath, im, bookEntry.playText, bookEntry.totalLength, m)
       if (im.length < 1 && m.length > 0) {
           for (var i in m) {
               bookEntry.dataDir = m[i];
               im = bookEntry.coverImagePath
               m = bookEntry.playFiles
               console.log("Subdir: Cover: " + im + ', music: ' + m)
           }
       }
   }
}

