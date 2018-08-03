#include "httppost.h"
#include <QUrlQuery>
#include <QFile>
#include <QJsonParseError>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDebug>

HTTPPost::HTTPPost()
{
    m_pNetWorkManager = new QNetworkAccessManager();
    connect(m_pNetWorkManager,SIGNAL(finished(QNetworkReply*)),this,SLOT(replyFinished(QNetworkReply*)));
}

HTTPPost::~HTTPPost()
{
    delete m_pNetWorkManager;
}

void HTTPPost::start()
{
    if(m_strFilePath.isEmpty() || m_strServerAddr.isEmpty()){
        return;
    }
    QFile file(m_strFilePath);
    if (!file.open(QIODevice::ReadOnly)||file.size()==0)
    {
       file.close();
       return ;
    }
    QByteArray fdata = file.readAll();
    if(fdata.isEmpty()){
        return;
    }
    file.close();
    QUrlQuery params;
    params.addQueryItem("file",fdata.toBase64());
//    qDebug() <<params.toString()<<endl;

    QNetworkRequest request;
    QString data = params.toString();

    request.setUrl(m_strServerAddr);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded;charset=utf-8");
    request.setHeader(QNetworkRequest::ContentLengthHeader, data.size());
    qDebug() << request.url() <<endl;
    m_pNetWorkManager->post(request, params.toString().toUtf8());
    qDebug() << "0000"<<endl;
}

void HTTPPost::replyFinished(QNetworkReply *reply)
{
    qDebug() << "0000.5"<<endl;
    QByteArray ba = reply->readAll();
    qDebug() <<reply->header(QNetworkRequest::ContentTypeHeader);
//    qDebug() <<reply->header("X-XSS-Protection");
//    qDebug() <<reply->header("Connection");
    qDebug() <<reply->header(QNetworkRequest::ServerHeader);
//    qDebug() <<reply->header(QNetworkRequest::DateHeader);

    QJsonParseError jsonpe;
    QJsonDocument json = QJsonDocument::fromJson(ba, &jsonpe);
    qDebug() << "0001"<<endl;
    qDebug() << jsonpe.error <<endl;
    if (jsonpe.error == QJsonParseError::NoError)
    {
        qDebug() << "0002"<<endl;
        if (json.isObject())
        {
            qDebug() << "0003"<<endl;
            QJsonObject obj = json.object();
            if (obj.contains("error_code"))
            {
                if(obj["error_code"] == 0){//成功
                    if(obj.contains("url")){
                        qDebug() << "1 obj[url] = " << obj["url"].toString();
                        emit sigReplyMessage(0,obj["url"].toString());
                    }
                }
                else{
                    if(obj.contains("message")){
                        qDebug() << "2 obj[message] = " << obj["message"];
                        emit sigReplyMessage(1,obj["message"].toString());
                    }
                }
            }
        }
        else
        {
            qDebug() << "3 error, shoud json object";
        }
    }
    else
    {
        qDebug() << "4 error:" << jsonpe.errorString();
    }

}
