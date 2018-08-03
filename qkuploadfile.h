#ifndef QKUPLOADFILE_H
#define QKUPLOADFILE_H
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QFile>

class QKUploadFile: public QObject
{
    Q_OBJECT
public:
    QKUploadFile();
    ~QKUploadFile();
    void UpLoadForm(QFile *uploadFile,
                    QString plateID,
                    QString status,
                    QString locationID,
                    QString time,
                    QString pic);
    static QKUploadFile * getInstance();
//    void UpLoadForm(QFile *uploadFile);
private:
    QNetworkAccessManager *_uploadManager;
    QNetworkReply *_reply;
    char *m_buf;
    QString filename;
    static QKUploadFile *d;

    QString plateID;
    QString status;
    QString locationID;
    QString time;
    QString pic;

private slots:
    void replyFinished(QNetworkReply *reply);
    void upLoadError(QNetworkReply::NetworkError errorCode);
    void OnUploadProgress(qint64 bytesSent, qint64 bytesTotal);
};

#endif // QKUPLOADFILE_H
