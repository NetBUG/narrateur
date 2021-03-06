import QtQuick 2.0
import Sailfish.Silica 1.0
//import harbour.sirensong 1.0  //~ TODO: replace with our model with play/stop
import "functions.js" as UIFunctions

ListItem {
    id: bookIt
    menu: ContextMenu {
        MenuItem {
            text: qsTr("Add to Play Queue")
            onClicked: {//SirenSong.addToPlaylist(url)
            }
        }
        MenuItem {
            text: qsTr("Rename")
            onClicked: {
                var dialog =
                pageStack.push(Qt.resolvedUrl("RenameDialog.qml"),
                    {"name": model.bookName});
                dialog.accepted.connect(function() {
                    model.bookName = dialog.name;
                    dao.updateBookName(model.id, dialog.name)
                    bookNameLs.text = dialog.name;
                });
            }
        }
        MenuItem {
            text: qsTr("Remove from list")
            onClicked: {
                dao.removeBook(model.id)
                listPage.populateBookList()
            }
        }
    }

    onClicked: {
        console.log("Playing book " + model.id)
        var playerPage = Qt.resolvedUrl("PlayerPage.qml")
//        if (!pageStack.contains(playerPage)) {
            pageStack.push(playerPage, { bookid: model.id })
//        } else {
//            pageStack.navigateForward(PageStackAction.Animated)
//        }
    }

    Row {
        x: 10
        spacing: 15

        Label {
            text: UIFunctions.durationString(model.duration)
            height: Theme.itemSizeHuge
            font.pixelSize: Theme.fontSizeExtraLarge
            color: Theme.secondaryColor
        }

        Column {
            Label {
                id: bookNameLs
                text: model.bookName
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.primaryColor
            }
            Label {
                text: model.bookDir //model.bookDir !== null ? model.bookDir : qs_Tr("wer")
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
            }
        }
    }

 }  //+ ListItem

