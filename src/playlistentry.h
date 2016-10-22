#ifndef PLAYLISTENTRY_H
#define PLAYLISTENTRY_H

#include <QObject>
#include <QString>

/**
 * @brief The PLAYLISTENTRY class provides information about
 * a playlist entry (one or more connected files).
 */
class PlaylistEntry : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QVariantList playFiles READ getPlayFiles NOTIFY playFilesChanged)
    Q_PROPERTY(QString coverImagePath READ coverImagePath WRITE setCoverImage NOTIFY coverImageChanged)
    Q_PROPERTY(QString playText READ getPlayText WRITE setPlayText NOTIFY playTextChanged)
    Q_PROPERTY(int posFile READ posFile WRITE setPosFile NOTIFY posFileChanged)
    Q_PROPERTY(int posTime READ posTime WRITE setTimFile NOTIFY posTimeChanged)
    Q_PROPERTY(QString dataDir READ dataDir WRITE setDataDir NOTIFY dataDirChanged)  //+ notify(!)

    Q_PROPERTY(QString cacheDir READ cacheDir NOTIFY cacheDirChanged)
public:
    explicit PlaylistEntry(QObject *parent = 0);
    QString cacheDir();
    QString dataDir();
    QVariantList getPlayFiles();
    QString coverImagePath();
    QString getPlayText();
    int posFile();
    int posTime();

    void setPosFile(int);
    void setTimFile(int);
    void setDataDir(QString dirPath);
    void setCoverImage(QString imagePath);
    void setPlayText(QString imagePath);

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
};

#endif // PLAYLISTENTRY_H
