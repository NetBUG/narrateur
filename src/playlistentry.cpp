#include "playlistentry.h"
#include <sailfishapp.h>
#include <QStandardPaths>
#include <string.h>

PlaylistEntry::PlaylistEntry(QObject *parent) : QObject(parent)
{
}

QString PlaylistEntry::dataDir() {
    return this->dataDir();
}

QString PlaylistEntry::cacheDir() {
    return QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
}

QVariantList PlaylistEntry::getPlayFiles() {
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

void checkImages(QString path) {
    QDirIterator it(path, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QString fn = it.next();
        qDebug() << fn;
    }
}   //+ checkImages

void PlaylistEntry::setDataDir(QString dirPath) {
    qDebug() << "Scanning " << dirPath;
    this->dataPath = dirPath;
    this->coverImagePath() = "";
    checkImages(dirPath);

}
