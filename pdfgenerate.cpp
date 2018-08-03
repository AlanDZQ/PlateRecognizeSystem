#include "pdfgenerate.h"

#include "qrcode/qrencode.h"
#include<QPainter>
#include <QPainter>
#include<QList>
#include<QDateTime>
#include<qprinter.h>
#include<QTextDocument>
#include<QStringList>
#include<QImage>
#include<QByteArray>
#include<QBuffer>
#include <QDebug>
#include <QtSql>
#include <QPainter>
#include <QColor>
#include <QRectF>
#include <QImage>
#include <QPixmap>

Pdfgenerate::Pdfgenerate(QObject *parent){}
Pdfgenerate::~Pdfgenerate(){}

QImage Pdfgenerate::GenerateQRcode(QString tempstr)
{
    QRcode *qrcode;
    qrcode=QRcode_encodeString(tempstr.toStdString().c_str(),2,QR_ECLEVEL_Q,QR_MODE_8,1);
    qint32 temp_width=150;
    qint32 temp_height=150;
    //qDebug()<<"temp_width="<<temp_width<<";temp_height="<<temp_height;
    qint32 qrcode_width=qrcode->width>0?qrcode->width:1;
    double scale_x=(double)temp_width/(double)qrcode_width;
    double scale_y=(double)temp_height/(double)qrcode_width;
    QImage mainimg=QImage(temp_width,temp_height,QImage::Format_ARGB32);
    QPainter painter(&mainimg);
    QColor background(Qt::white);
    painter.setBrush(background);
    painter.setPen(Qt::NoPen);
    painter.drawRect(0,0,temp_width,temp_height);
    QColor foreground(Qt::black);
    painter.setBrush(foreground);
    for(qint32 y=0;y<qrcode_width;y++)
    {
        for(qint32 x=0;x<qrcode_width;x++)
        {
            unsigned char b=qrcode->data[y*qrcode_width+x];
            if(b &0x01)
            {
                QRectF r(x*scale_x,y*scale_y,scale_x,scale_y);
                painter.drawRects(&r,1);
            }
        }
    }

    return mainimg;
}

QList<QString> Pdfgenerate::FetchCustomerData(QString tempStr){
    QList<QString> list = {};
    QSqlQuery query;
    query.exec("SELECT * FROM NEUSOFT1.EXPORT_INFO WHERE eserialID='"+tempStr+"'");
    if(query.first()){
        list.append(query.value(4).toString());
        list.append(query.value(5).toString());
        list.append(query.value(6).toString());
        list.append(query.value(0).toString());
        //list.append(QVariant::fromValue(ei));
    }else {
        qDebug()<<"Empty Query - Customer Data";
    }
    return list;
}

QString Pdfgenerate::GetGoodByID(QString goodID){
    QString goodName;
    QSqlQuery query;
    query.exec("SELECT * FROM NEUSOFT1.GOODS_INFO WHERE goodID='"+goodID+"'");
    if(query.first()){
        goodName = query.value(5).toString();
    }else{
        qDebug()<<"Empty Query - GetGood";
    }
    return goodName;
}

QList<QList<QString>> Pdfgenerate::FetchGoodsData(QString tempStr){
    QList<QList<QString>> list = {};
    QSqlQuery query;
    query.exec("SELECT * FROM NEUSOFT1.EXPORT_GOODS_INFO WHERE eserialID='"+tempStr+"'");
    if(query.first()){
        //qDebug()<<query.size();
        for(int i=0;i<query.size();i++){
            QList<QString> tempList = {};
            tempList.append(query.value(1).toString());
            tempList.append(GetGoodByID(query.value(1).toString()));
            //qDebug()<<query.value(1).toString();
            tempList.append(query.value(2).toString());
            list.append(tempList);
            query.next();

        }
    }else{
        qDebug()<<"Empty Query - Goods Data";
    }
    return list;
}

QList<QString> Pdfgenerate::FetchDeliveryData(QString tempStr){
    QList<QString> list = {};
    QSqlQuery query;
    query.exec("SELECT * FROM NEUSOFT1.EXPORT_INFO WHERE eserialID='"+tempStr+"'");
    if(query.first()){
        list.append(query.value(2).toString());
        list.append(query.value(1).toString());
        list.append(query.value(4).toString());
        list.append(query.value(6).toString());
        list.append(query.value(5).toString());
    }else {
        qDebug()<<"Empty Query - Customer Data";
    }
    return list;
}

void Pdfgenerate::deliveryGenerate(QString serial, QString plateID, QString carType, QString enterChkpt, QString enterTime, QString exitChkpt, QString exitTime, QString distance, QString charge, QString path){
    //html生成
    QString html;
    html += "<table border=\"1\" width=500px>"
                "<tr >"
                    "<td colspan=\"4\" align=\"center\" height=50px><big>高速公路缴费收据</big></td>"
                "</tr>";
    html += QString("<tr>"
            "<td width=75px align=\"center\">流水号</td>"
            "<td colspan=3 align=\"center\">%1</td>"
            "</tr>"
            "<tr>"
            "<td width=75px align=\"center\">车牌号</td>"
            "<td width=175px align=\"center\">%2</td>"
            "<td width=75px align=\"center\">车型</td>"
            "<td width=175px align=\"center\">%3 类</td>"
            "</tr>"
            "<tr >"
            "<td height=30px align=\"center\">进入站点</td>"
            "<td align=\"center\">%4</td>"
            "<td align=\"center\">总时长</td>"
            "<td align=\"center\">%5</td>"
            "</tr>"
            "<tr >"
            "<td height=30px align=\"center\">出站站点</td>"
            "<td align=\"center\">%6</td>"
            "<td align=\"center\">出站时间</td>"
            "<td align=\"center\">%7</td>"
            "</tr>"
            "<tr >"
            "<td height=30px align=\"center\">行驶里程</td>"
            "<td align=\"center\">%8 公里</td>"
            "<td align=\"center\">应收费用</td>"
            "<td align=\"center\">%9 元</td>"
            "</tr>").arg(serial,plateID,carType,enterChkpt,enterTime,exitChkpt,exitTime,distance,charge);
    html += "</table>";
    //PDF打印
    QTextDocument text_document;
    text_document.setHtml(html);
    QPrinter *printer_html = new QPrinter;
    printer_html->setPageSize(QPrinter::A4);
    printer_html->setOutputFormat(QPrinter::PdfFormat);
    path = path.right(path.length()-7);
    qDebug()<<path;
    printer_html->setOutputFileName(path);
    text_document.print(printer_html);
}


bool Pdfgenerate::orderListGenerate(QString tempStr, QString path){
    QList<QString> customerData = FetchCustomerData(tempStr);
    QList<QList<QString>> goodData = FetchGoodsData(tempStr);
    QImage QRCImg = GenerateQRcode(tempStr);
    QByteArray QRCba;
    QBuffer buf(&QRCba);
    QRCImg.save(&buf,"PNG",20);
    QByteArray hexed = QRCba.toBase64();
    QString QRCStr = hexed.prepend(hexed);
    //html生成
    QString html;
    html += "<table class = 'expressInfo' border=\"3\" width=\"600\">"
            "<tr class='warehouseInfo'>";
    html += QString(
                    "<td colspan=\"3\" align=\"center\" valign='center'>"
                    "<dl id='orderInfoList'>"
                        "<dt><font size=\"48\">逆风物流</font></dt>"
                        "<dt><font size=\"24\">出货单</font></dt>"
                        "<dt>收货人:%2</dt>"
                        "<dt>收货地址:%3</dt>"
                        "<dt>联系方式:%4</dt>"
                        "<dt>订单号:%5</dt>"
                    "</dl>"
                    "</td>"
                    "<td width=\"160\" align=\"justify\"><img src=\"data:image/png;base64,%6\" width = '160px' height = '160px'></td>")
            .arg(customerData.at(0),customerData.at(1),customerData.at(2),customerData.at(3),QRCStr);
    html += "</tr>";
    html += "<tr>";
    html += "<td  colspan=\"4\" align=\"center\">";
    html += "<div id = 'orderTable' cellpadding=\"10\">"
                "<table>"
                    "<tr id = 'title' border =\"1\">"
                        "<td class = 'goodId' align=\"center\" width=\"100\">商品编号</td>"
                        "<td class = 'goodName' align=\"center\" colspan=\"3\" width=\"300\">商品名</td>"
                        "<td class = 'quantity' align=\"center\" width=\"100\">数量</td>"
                    "</tr>";
    for(int i=0;i<goodData.size();i++){
        html += QString("<tr id = 'detail' border =\"1\">"
                            "<td class = 'goodId' align=\"center\" width=\"100\">%1</td>"
                            "<td class = 'goodName' align=\"center\" colspan=\"3\" width=\"300\">%2</td>"
                            "<td class = 'quantity' align=\"center\" width=\"100\">%3</td>"
                            "</tr>").arg(goodData.at(i).at(0),goodData.at(i).at(1),goodData.at(i).at(2));
    }
    html += "</table>";
    html += "<tr id = 'total' border =\"1\">"
                "<td colspan=\"4\"></td>"
            "</tr>"
            "</table>"
            "</div>";

    //PDF打印
    QTextDocument text_document;
    text_document.setHtml(html);
    QPrinter *printer_html = new QPrinter;
    printer_html->setPageSize(QPrinter::A3);
    printer_html->setOutputFormat(QPrinter::PdfFormat);
    path = path.right(path.length()-7);
    printer_html->setOutputFileName(path);
    text_document.print(printer_html);
}

