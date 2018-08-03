#include "qkuploadfile.h"

#include <QUrlQuery>
#include <QFile>
#include <QJsonParseError>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDebug>
#include <QDataStream>
#include <QUuid>
#include <QSqlQuery>

QKUploadFile *QKUploadFile::d = 0;

QKUploadFile::QKUploadFile()
{
//    QFileDialog dialog(this);
//    filename = dialog.getOpenFileName(0, "/");

    _uploadManager = new QNetworkAccessManager(this);
    connect(_uploadManager,SIGNAL(finished(QNetworkReply*)),SLOT(replyFinished(QNetworkReply*)));
    m_buf = NULL;
}

QKUploadFile::~QKUploadFile()
{
    if( m_buf != NULL ) delete[] m_buf;
}

QKUploadFile * QKUploadFile::getInstance()
{
    if (d == 0)
        d = new QKUploadFile;
    return d;
}


//void QKUploadFile::uploadFile(QString uploadFilename)
//{
//    QFile file(uploadFilename);
//    file.open(QIODevice::ReadOnly);
//    int  file_len = file.size();

//    QDataStream in(&file);
//    m_buf = new char[file_len];
//    in.readRawData( m_buf, file_len);
//    file.close();

//    QUrl url = QString("http://121.42.252.18:5000/uploadimage1");
//    QNetworkRequest request( url );

//    request.setHeader(QNetworkRequest::ContentTypeHeader, "multipart/form-data");

//    qDebug()<<"0001";
//    request.setRawHeader("filename", uploadFilename.section('/', -1, -1).toUtf8() );
////    qDebug()<<request.rawHeader("filename");

//    QByteArray arr = QByteArray( m_buf, file_len );
//    _reply = _uploadManager->post( request , arr );

//    qDebug()<<"0002";

//    connect(_reply, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(upLoadError(QNetworkReply::NetworkError)));
//    connect(_reply, SIGNAL(uploadProgress ( qint64 ,qint64 )), this, SLOT( OnUploadProgress(qint64 ,qint64 )));

//    qDebug()<<"0003";
//    qDebug() <<request.rawHeaderList();

//}

void QKUploadFile::UpLoadForm(QFile *uploadFile,
                              QString plateID,
                              QString status,
                              QString locationID,
                              QString time,
                              QString pic){

    this->plateID = plateID;
    this->status = status;
    this->locationID = locationID;
    this->time = time;

    QString Path="http://121.42.252.18:5000/uploadimage1";
    QString fileFormName="file";
    QString newFileName="0.jpg";
    QString BOUNDARY=QUuid::createUuid().toString();
    QByteArray sb=QByteArray();
    //先上传普通的表单数据
    //上传文件的头部
    sb.append("--"+BOUNDARY+"\r\n");
    sb.append(QString("Content-Disposition: form-data;name=\"")+fileFormName+QString("\";filename=\"")+newFileName+QString("\"")+QString("\r\n"));
    sb.append(QString("Content-Type: image/jpg")+QString("\r\n"));
    sb.append("\r\n");
    //上传文件内容
    if(!uploadFile->open(QIODevice::ReadOnly)){
        return;
    }
    sb.append(uploadFile->readAll());
    sb.append("\r\n");
    sb.append("--"+BOUNDARY+"--\r\n");
    //编辑HTTP头部
//    QNetworkAccessManager *_uploadManager=new QNetworkAccessManager();
    QNetworkRequest request=QNetworkRequest(QUrl(Path));
    request.setRawHeader(QString("Content-Type").toLatin1(),QString("multipart/form-data;boundary="+BOUNDARY).toLatin1());
    request.setRawHeader(QString("Content-Length").toLatin1(),QString::number(sb.length()).toLatin1());
    //执行post请求
    QNetworkReply *reply;
    reply=_uploadManager->post(request,sb);

//    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(upLoadError(QNetworkReply::NetworkError)));
//    connect(reply, SIGNAL(uploadProgress ( qint64 ,qint64 )), this, SLOT( OnUploadProgress(qint64 ,qint64 )));

//    qDebug()<<"0004";
//    qDebug() <<reply->rawHeaderList();
//    qDebug() <<reply->header(QNetworkRequest::ContentTypeHeader);

//    if(reply->error() == QNetworkReply::NoError)
//    {
//        qDebug()<<"no error.....";
//        QByteArray bytes = reply->readAll();  //获取字节
//        QString result(bytes);  //转化为字符串
//        qDebug()<<result;
//    }else{
//        qDebug()<<"0005";
//        qDebug() << "replyFinished:  " << reply->error() << " " <<reply->errorString();
//    }

//    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
//    qDebug()<<status_code;
//    qDebug()<<"0006";
}


void QKUploadFile::replyFinished(QNetworkReply *reply)
{
//    qDebug()<<"0004";
//    qDebug() <<reply->rawHeaderList();
//    qDebug() <<reply->header(QNetworkRequest::ContentTypeHeader);

    if(reply->error() == QNetworkReply::NoError)
    {
//        qDebug()<<"000#1";
//        qDebug()<<"no error.....";
        QByteArray bytes = reply->readAll();  //获取字节
        QString result(bytes);  //转化为字符串
        qDebug()<<result;
        QSqlQuery query;
        QString sqlquery = QString("insert into NEUSOFT2.CAR_STATUS_TIME_INFO (`plateID`, `status`, `locationID`, `time`, `pic`) "
                                   "values('%1','%2','%3','%4','%5')")
                .arg(plateID,status,locationID)
                .arg(time)
                .arg(result);
        qDebug()<<sqlquery;
        query.exec(sqlquery);
    }
    else{
        qDebug()<<"0005";
        qDebug() << "replyFinished:  " << reply->error() << " " <<reply->errorString();
    }

//    QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
//    qDebug()<<status_code;
//    qDebug()<<"0006";
}

void QKUploadFile::upLoadError(QNetworkReply::NetworkError errorCode)
{
    qDebug() << "upLoadError  errorCode: " << (int)errorCode;
    qDebug()<<"0007";
}

void QKUploadFile::OnUploadProgress(qint64 bytesSent, qint64 bytesTotal)
{
    qDebug() << "bytesSent: " << bytesSent << "  bytesTotal: "<< bytesTotal;
    qDebug()<<"0008";
}
