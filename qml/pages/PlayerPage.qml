import QtQuick 2.2
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import Sailfish.Media 1.0

Page {
    id: player_page
    property var bookid;
    property var dao;

    Video {
        id: player
        Component.onUrlChanged: {
            console.log("Test if new file loading triggers this event...")
            dao.updateFile(bookid, player.source, player.position / 1000);
        }
    }

    MediaPlayerControlsPanel {
        id: audioPlayer
        active: true
        open: true
        //playing: player.isPlaying
        //author: player.author
        //title: player.title
        duration: player.duration   //? / 1000?
        position: player.position / 1000

        onPlayPauseClicked: {
            if (playing) player.pause()
            else player.play()
        }
        onPreviousClicked: if (player.currentIndex > 0) player.prev()
        onNextClicked: if (player.currentIndex < player.size-1) player.next()
        onSliderReleased: player.seek(value)
        onRepeatClicked: {
            player.repeat = !player.repeat
            repeat = player.repeat ? MediaPlayerControls.RepeatTrack :
                                     MediaPlayerControls.NoRepeat
        }
        onShuffleClicked: {
            player.shuffle = !player.shuffle
            shuffle = player.shuffle ? MediaPlayerControls.ShuffleTracks :
                                       MediaPlayerControls.NoShuffle
        }
    }

    Component.onCompleted: {
        var book = dao.getFile(bookid);
        console.log("Previous file: " + book[0])
        console.log("Current file: " + book[1])
        console.log("Next file: " + book[2])
        player.source = book[3]
    }
}

