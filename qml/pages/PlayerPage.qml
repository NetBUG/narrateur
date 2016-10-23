import QtQuick 2.2
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import Sailfish.Media 1.0

Page {
    id: player_page


    MediaPlayerControlsPanel {
        id: audioPlayer
        active: true
        open: true
        playing: player.isPlaying
        author: player.author
        title: player.title
        duration: player.duration
        position: player.position / 1000

        onPlayPauseClicked: {
            if (playing) player.pause()
            else player.play()
        }
        onPreviousClicked: if (player.currentIndex > 0) player.prev()
        onNextClicked: if (player.currentIndex < player.size-1) player.next()
        onSliderReleased: player.seekTo(value)
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
}

