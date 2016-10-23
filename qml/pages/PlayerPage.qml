import QtQuick 2.2
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import Sailfish.Media 1.0

Page {
    id: player_page
    property var bookid;
    property var dao;
    property var book;

    MediaPlayerControlsPanel {
        id: audioPlayer
        active: true
        open: true
        playing: mainPlayer.playbackState === MediaPlayer.PlayingState
        //author: player.author
        //title: player.title
        duration: mainPlayer.duration / 1000
        position: mainPlayer.position / 1000

        onPlayPauseClicked: {
            if (playing) {
                mainPlayer.seekpos = mainPlayer.position;
                dao.updateFile(bookid, mainPlayer.source, mainPlayer.position);
                mainPlayer.pause()
            }
            else mainPlayer.play()
        }
        onPreviousClicked: {mainPlayer.source = book[0]; dao.updateFile(bookid, mainPlayer.source, mainPlayer.position); book = dao.getFile(bookid)}
        onNextClicked: {mainPlayer.source = book[2]; dao.updateFile(bookid, mainPlayer.source, mainPlayer.position); book = dao.getFile(bookid)}
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

    Component.onCompleted: {
        book = dao.getFile(bookid);
        mainPlayer.seekpos = book[3];
        //console.log("Previous file: " + book[0])
        console.log("Current file: " + book[1])
        console.log("Next file: " + book[2])
        mainPlayer.source = book[1]
        mainPlayer.play()
    }
}

