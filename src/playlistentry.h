#ifndef PLAYLISTENTRY_H
#define PLAYLISTENTRY_H

#include <QObject>
#include <QString>
#include <QVariantMap>
#include <QtMultimedia/QMediaPlayer>

/**
 * @brief The PLAYLISTENTRY class provides information about
 * a playlist entry (one or more connected files).
 */
class PlaylistEntry : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QVariantList playFiles READ getPlayFiles NOTIFY playFilesChanged)
    Q_PROPERTY(QString coverImagePath READ coverImagePath WRITE setCoverImage NOTIFY coverImageChanged)
    Q_PROPERTY(QString name READ getName)
    Q_PROPERTY(int totalLength READ getLength)
    Q_PROPERTY(QString playText READ getPlayText WRITE setPlayText NOTIFY playTextChanged)
    Q_PROPERTY(int posFile READ posFile WRITE setPosFile NOTIFY posFileChanged)
    Q_PROPERTY(int posTime READ posTime WRITE setTimFile NOTIFY posTimeChanged)
    Q_PROPERTY(QString dataDir READ dataDir WRITE setDataDir NOTIFY dataDirChanged)  //+ notify(!)

    Q_PROPERTY(QString cacheDir READ cacheDir NOTIFY cacheDirChanged)
public:
    explicit PlaylistEntry(QObject *parent = 0);
    QString cacheDir();
    QString dataDir();
    const QVariantList& getPlayFiles();
    QString coverImagePath();
    QString getPlayText();
    QString getName();
    int getLength();
    int posFile();
    int posTime();

    void setPosFile(int);
    void setTimFile(int);
    void setDataDir(QString dirPath);
    void setCoverImage(QString imagePath);
    void setPlayText(QString imagePath);
    QMediaPlayer* player;

signals:
    void cacheDirChanged();
    void dataDirChanged();
    void coverImageChanged();
    void playFilesChanged();
    void playTextChanged();
    void posFileChanged();
    void posTimeChanged();
public slots:

private:
    QString coverImage;
    QString playText;
    QString dataPath;
    QVariantList playFiles;
    int pos_file;
    int pos_time;
    int total_length;
    QVariantList scanMusic(QString path);
};

#endif // PLAYLISTENTRY_H
