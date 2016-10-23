import QtQuick 2.2
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import Sailfish.Media 1.0

Page {
    id: player_page
    property var bookid;
    property var book;
//    Column {
//        anchors.fill: parent

        Label {
            id: currentFN
        }
        Image {
            anchors.centerIn: parent
            id: cover_img
            fillMode: Image.PreserveAspectFit
            width: 600
            height: 600
        }
//    }


    MediaPlayerControlsPanel {
        id: audioPlayer
        active: true
        open: true
        //author: player.author
        //title: player.title
        duration: mainPlayer.duration / 1000
        position: mainPlayer.position / 1000

        onPlayPauseClicked: {
            if (mainPlayer.playbackState === MediaPlayer.PlayingState) { mainPlayer.pause() }
            else mainPlayer.play()
        }
        onPreviousClicked: { loaded(book[0], true); }
        onNextClicked: { loaded(book[2], true); }
        onSliderReleased: mainPlayer.seek(value * 1000)
        onRepeatClicked: {
            mainPlayer.repeat = !mainPlayer.repeat
            repeat = mainPlayer.repeat ? MediaPlayerControls.RepeatTrack :
                                     MediaPlayerControls.NoRepeat
        }
        onShuffleClicked: {
            mainPlayer.shuffle = !mainPlayer.shuffle
            shuffle = mainPlayer.shuffle ? MediaPlayerControls.ShuffleTracks :
                                       MediaPlayerControls.NoShuffle
        }
    }

    function loaded(fn, update) {
        mainPlayer.stop()
        mainPlayer.source = fn
        if (update) dao.updateFile(bookid, mainPlayer.source, mainPlayer.position);
        book = dao.getFile(bookid)
        mainPlayer.seekpos = book[3]
        mainPlayer.seek(mainPlayer.seekpos)
        //console.log (mainPlayer.source + " @ " + mainPlayer.seekpos)
        currentFN.text = mainPlayer.source
        mainPlayer.play()
    }

    Component.onCompleted: {
        book = dao.getFile(bookid);
        cover_img.source = Qt.resolvedUrl("file://" + dao.getBookInfo(bookid)[0]);
        mainPlayer.bookid = bookid;
        //console.log("Previous file: " + book[0])
        //console.log("Current file: " + book[1] + " @ " + book[3])
        //console.log("Next file: " + book[2])
        loaded(book[1], false)
    }
}

