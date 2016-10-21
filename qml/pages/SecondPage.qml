import QtQuick 2.2
import Sailfish.Silica 1.0
import QtMultimedia 5.0

Page {
    id: page
    MediaPlayer {
        id: player
        source: "/home/nemo/Videos/Default/Sailfish_OS_2.0.mp4"
        //source: "http://192.168.1.20:41020/Sailfish_OS_2.0.mp4"
    }
    VideoOutput {
        anchors.fill: parent
        source: player
    }
    Label {
        id: invitationLabel
        z: 1
        anchors.centerIn: parent
        text: "Коснитесь для начала воспроизведения"
    }
    MouseArea {
        id: playArea
        anchors.fill: parent
        onPressed: {
            if (player.playbackState == MediaPlayer.PlayingState) {
                invitationLabel.visible = true
                player.pause();
            } else {
                invitationLabel.visible = false
                player.play();
            }
        }
    }
}
