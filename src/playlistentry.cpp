#include "playlistentry.h"
#include <sailfishapp.h>
#include <QStandardPaths>
#include <string.h>
#include <QDir>
#include <QDirIterator>
#include <QtMultimedia/QMediaPlayer>
#include <QtDBus>

void initializeDbus() {
    QDBusInterface * dbusVolume = new QDBusInterface("com.Meego.MainVolume2", "/com/meego/mainvolume2", "com.Meego.MainVolume2" );
}

PlaylistEntry::PlaylistEntry(QObject *parent) : QObject(parent)
{
    this->player = new QMediaPlayer();
    initializeDbus();
}

QString PlaylistEntry::dataDir() {
    return this->dataDir();
}

QString PlaylistEntry::cacheDir() {
    return QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
}

const QVariantList& PlaylistEntry::getPlayFiles() {
    return this->playFiles;
}

QString PlaylistEntry::coverImagePath() {
    return this->coverImage;
}

QString PlaylistEntry::getPlayText(){
    return this->playText;
}

int PlaylistEntry::posFile() { return this->pos_file; }
int PlaylistEntry::posTime() { return this->pos_time; }
int PlaylistEntry::getLength() { return this->total_length; }
QString PlaylistEntry::getName() {
    QString bo = this->dataPath;
    QFileInfo ql(bo);
    return ql.fileName();
}

void PlaylistEntry::setPosFile(int pos) {this->pos_file = pos; }
void PlaylistEntry::setTimFile(int pos) {this->pos_time = pos; }
void PlaylistEntry::setCoverImage(QString imagePath) { this->coverImage = imagePath; }
void PlaylistEntry::setPlayText(QString text) { this->playText = text; }

//+ @brief Returns if folder immediately has image
QString findImage(QString path) {
    QDirIterator it(path);
    while (it.hasNext()) {
        QString fn = it.next();
//        qDebug() << ".jpg search: " << fn;
        if (fn.endsWith(".jpg") || fn.endsWith(".png"))
            return fn;
    }
    return "";
}   //+ checkImages

//+ @brief Returns true if folder has music/subfolders with music
bool checkMusic(QString path) {
    QDirIterator it(path, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QString fn = it.next().replace(path, "");
        if (fn.count("/") > 3)
            continue;
        if (fn.endsWith(".mp3") || fn.endsWith(".ogg"))
            return true;
    }
    return false;
}

//+ @brief Scan for books
QList<QVariant> PlaylistEntry::scanMusic(QString path) {
    QList<QVariant>* lsOut = new QList<QVariant>();
    QDirIterator it(path, QDirIterator::Subdirectories);
    this->total_length = 0;
    QMediaPlayer *player = new QMediaPlayer;
    while (it.hasNext()) {
        QString fn = it.next();
        if (fn.replace(path, "").count("/") > 3)
            continue;
        if (fn.endsWith(".mp3") || fn.endsWith(".ogg"))
        {
            lsOut->append(path + fn);
            try {
                player->setMedia(QUrl::fromLocalFile(path + fn));
                this->total_length += player->duration() / 1000;
            } catch(...) {
                qDebug("Error reading file length");
            }
        }
    }
    return *lsOut;
}

void PlaylistEntry::setDataDir(QString dirPath) {
    this->dataPath = dirPath.replace("file://", "");
    QString ci = findImage(this->dataPath);
    if (checkMusic(this->dataPath) && ci != "")
    {
        qDebug("Added current dir");
        this->setCoverImage(ci);
        this->playFiles = scanMusic(this->dataPath);
    } else {
        QDirIterator it(this->dataPath);
        while (it.hasNext()) {
            QString fn = it.next();
            QFileInfo dir(fn);
            if (!dir.isDir()) continue;
            if (checkMusic(fn) && findImage(fn) != "") {
                this->playFiles.append(fn);
                qDebug() << "Added book dir: " << fn;
            }

        }
    }
}
