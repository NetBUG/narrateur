import QtQuick 2.2
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import Sailfish.Media 1.0

Page {
    id: player_page
    property var bookid;
    property var dao;
    property var book;
    property var seekpos;

    Video {
        id: player
        onSeekableChanged: {
            if (!player.seekable) return;
            console.log("Seeking to " + seekpos + " " + player.seekable)
            player.seek(seekpos);
        }
    }

    MediaPlayerControlsPanel {
        id: audioPlayer
        active: true
        open: true
        playing: player.playbackState == MediaPlayer.PlayingState
        //author: player.author
        //title: player.title
        duration: player.duration / 1000
        position: player.position / 1000

        onPlayPauseClicked: {
            if (playing) {
                seekpos = player.position;
                dao.updateFile(bookid, player.source, player.position);
                player.pause()
            }
            else player.play()
        }
        onPreviousClicked: {player.source = book[0]; dao.updateFile(bookid, player.source, player.position); book = dao.getFile(bookid)}
        onNextClicked: {player.source = book[2]; dao.updateFile(bookid, player.source, player.position); book = dao.getFile(bookid)}
        onSliderReleased: player.seek(value * 1000)
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
        book = dao.getFile(bookid);
        seekpos = book[3];
        //console.log("Previous file: " + book[0])
        console.log("Current file: " + book[1])
        console.log("Next file: " + book[2])
        player.source = book[1]
        player.play()
    }
}

