import QtQuick 2.0
import Sailfish.Silica 1.0
//import harbour.sirensong 1.0  //~ TODO: replace with our model with play/stop
import "functions.js" as UIFunctions

ListItem {
    width: parent.width
    height: Theme.itemSizeMedium
    menu: ContextMenu {
        MenuItem {
            text: qsTr("Add to Play Queue")
            onClicked: {//SirenSong.addToPlaylist(url)
            }
        }
        MenuItem {
            text: qsTr("Rename")
            onClicked: {//SirenSong.addToPlaylist(url)
            }
        }
        MenuItem {
            text: qsTr("Remove from list")
            onClicked: {//SirenSong.addToPlaylist(url)
            }
        }
    }

    onClicked: {
        //~ SirenSong.play(url)
        if (libraryPage.forwardNavigation) {
            pageStack.navigateForward(PageStackAction.Animated)
        }
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

