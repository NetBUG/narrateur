#include "playlistentry.h"
#include <sailfishapp.h>
#include <QStandardPaths>

PlaylistEntry::PlaylistEntry(QObject *parent) : QObject(parent)
{
}

QString PlaylistEntry::dataDir() {
    return SailfishApp::pathTo("./").toString();
}

QString PlaylistEntry::cacheDir() {
    return QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
}

QVector<QString>* PlaylistEntry::getPlayFiles() {
    return this->playFiles;
}

QString PlaylistEntry::coverImagePath() {
    return "";
}

QString PlaylistEntry::getPlayText(){
    return "";
}

int PlaylistEntry::posFile() { return this->pos_file; }
int PlaylistEntry::posTime() { return pos_time; }

void PlaylistEntry::setPosFile(int pos) {this->pos_file = pos; }
void PlaylistEntry::setTimFile(int pos) {this->pos_time = pos; }
void PlaylistEntry::setCoverImage(QString imagePath) { coverImage = imagePath; }
void PlaylistEntry::setPlayText(QString text) { playText = text; }
