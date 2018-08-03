#include "car_status_timecontroller.h"
#include "car_status_time.h"
#include "car.h"
#include "toll_time.h"
#include <QSqlQuery>
#include <QSqlDatabase>
#include <QDebug>
#include <string>
#include "QKUploadFile.h"
#include "volume_time.h"
using namespace std;

Car_status_timeController::Car_status_timeController(QObject *parent){}
Car_status_timeController::~Car_status_timeController(){}


QList<QVariant> Car_status_timeController:: openCar_status_time(){
    QList<QVariant> list = {};
    QSqlQuery query;
    query.exec("SELECT * FROM NEUSOFT2.CAR_STATUS_TIME_INFO;");
    while(query.next()){
        Car_status_time* cst = new Car_status_time(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                        query.value(3).toString(), query.value(4).toDateTime(),
                                        query.value(5).toString());

        list.append(QVariant::fromValue(cst));
    }
    return list;

}

int Car_status_timeController:: findLastC(QString plateID,
                                          QString time){
    int c;
    QSqlQuery query;
    QString sqlquery = QString("select cserialID from CAR_STATUS_TIME_INFO where plateID='%1' AND time = '%2' ")
            .arg(plateID)
            .arg(time);
    qDebug()<<sqlquery;
    query.exec(sqlquery);
    while(query.next()){
        c = query.value(0).toInt();
    }

    return c;

}

void Car_status_timeController:: addCar_status_time(QString plateID,
                                                    QString status,
                                                    QString locationID,
                                                    QString time,
                                                    QString pic){

//    saveOperation(sqlquery);
//    undoData.clear();
//    undoData.append(userID);
//    undoData.append(password);
//    undoData.append(name);
//    undoData.append(gender);
//    undoData.append(age);
//    undoData.append(privilege);
//    undoData.append(salary);
//    undoData.append(email);
//    undoData.append(phone);
//    undoData.append(wagecardID);
//    undoData.append(url);

    //    this->lastClassNum = 8;
    QKUploadFile *upload = new QKUploadFile();
    QFile *file = new QFile(pic);
    upload->UpLoadForm(file,plateID,status,locationID,time,pic);

    qDebug()<<"addCar_status_time OK"<<endl;
}

void Car_status_timeController:: delCar_status_time(QString cserialID){
//    QSqlQuery query0;
//    QString sqlquery0 = QString("SELECT * FROM NEUSOFT1.IMPORT_GOODS_INFOWHERE iserialID = '%1'and goodID = '%2' ")
//            .arg(iserialID,goodID);
//    query0.exec(sqlquery0);
//    undoData.clear();
//    query0.next();

//    undoData.append(query0.value(0).toString());
//    undoData.append(query0.value(1).toString());
//    undoData.append(query0.value(2).toString());


//    this->lastClassNum = 6;

    QSqlQuery query;
    QString sqlquery = QString("DELETE FROM NEUSOFT2.CAR_STATUS_TIME_INFO WHERE cserialID = '%1' ")
            .arg(cserialID);

//    saveOperation(sqlquery);

    query.exec(sqlquery);
    qDebug()<<"delCar OK"<<endl;

}

void Car_status_timeController:: editCar_status_time(QString cserialID,
                                                     QString plateID,
                                                     QString status,
                                                     QString locationID,
                                                     QString time,
                                                     QString pic){
    //    int amount1 = amount.toInt();

//    QSqlQuery query0;
//       QString sqlquery0 = QString("SELECT * FROM NEUSOFT1.EXPORT_GOODS_INFO WHERE eserialID = '%1' AND goodID = '%2' ")
//               .arg(eserialID,goodID);
//       query0.exec(sqlquery0);
//       undoData.clear();
//       query0.next();

//       undoData.append(query0.value(0).toString());
//       undoData.append(query0.value(1).toString());
//       undoData.append(query0.value(2).toString());

//       this->lastClassNum = 2;
    QSqlQuery query;
    QString sqlquery = QString("UPDATE NEUSOFT2.CAR_STATUS_TIME_INFO SET plateID = '%2' , status = '%3', locationID = '%4'"
                               ", time = '%5', pic = '%6' WHERE cserialID = '%1'  ")
            .arg(cserialID,plateID,status,locationID)
            .arg(time)
            .arg(pic);

//    qDebug()<<sqlquery<<endl;
//    saveOperation(sqlquery);
    query.exec(sqlquery);
    qDebug()<<"editCar_status_time OK"<<endl;

}

QList<QVariant> Car_status_timeController:: searchCar_status_time(QString colName,QString theOne){
    QSqlQuery query;
    QList<QVariant> list = {};
    QString sqlquery = QString("SELECT * FROM NEUSOFT2.CAR_STATUS_TIME_INFO WHERE %1 = '%2' ")
            .arg(colName,theOne);
    qDebug()<<sqlquery;
    query.exec(sqlquery);
    while(query.next()){
        Car_status_time* cst = new Car_status_time(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                        query.value(3).toString(), query.value(4).toDateTime(),
                                        query.value(5).toString());

        list.append(QVariant::fromValue(cst));
    }
    return list;

}

QList<QVariant> Car_status_timeController:: sortCar_status_time(QString colName, bool asc){
    if(asc){
        QSqlQuery query;
            QList<QVariant> list = {};
            QString sqlquery = QString("SELECT * FROM NEUSOFT2.CAR_STATUS_TIME_INFO ORDER BY %1 asc")
                    .arg(colName);

            query.exec(sqlquery);
            while(query.next()){
                Car_status_time* cst = new Car_status_time(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                                query.value(3).toString(), query.value(4).toDateTime(),
                                                query.value(5).toString());

                list.append(QVariant::fromValue(cst));
            }
            return list;
    }else{
        QSqlQuery query;
            QList<QVariant> list = {};
            QString sqlquery = QString("SELECT * FROM NEUSOFT2.CAR_STATUS_TIME_INFO ORDER BY %1 desc")
                    .arg(colName);

            query.exec(sqlquery);
            while(query.next()){
                Car_status_time* cst = new Car_status_time(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                                query.value(3).toString(), query.value(4).toDateTime(),
                                                query.value(5).toString());

                list.append(QVariant::fromValue(cst));
            }
            return list;
    }

}

QList<QVariant> Car_status_timeController:: calToll_time(QString LocationID){
    QSqlQuery query;
    QList<QVariant> list = {};
    QString sqlquery = QString("SELECT DATE_FORMAT(CAR_STATUS_TIME_INFO.time,'%Y-%m-%d') as date,SUM(FINANCE_INFO.cost) as cost "
                               "FROM FINANCE_INFO, CAR_STATUS_TIME_INFO "
                               "WHERE FINANCE_INFO.cserialID = CAR_STATUS_TIME_INFO.cserialID and CAR_STATUS_TIME_INFO.locationID = '%1' "
                               "GROUP BY date "
                               "order by date asc")
            .arg(LocationID);
    qDebug()<<sqlquery;
    query.exec(sqlquery);

    while(query.next()){
        Toll_time* tt = new Toll_time(query.value(0).toDateTime(), query.value(1).toDouble());
        list.append(QVariant::fromValue(tt));
    }
    return list;
}

QList<QVariant> Car_status_timeController::calVolume_time(QString LocationID){
    QSqlQuery query;
    QList<QVariant> list = {};
    QString sqlquery = QString("SELECT DATE_FORMAT(CAR_STATUS_TIME_INFO.time,'%Y-%m-%d') as date,count(CAR_STATUS_TIME_INFO.plateID) as num "
                               "FROM CAR_STATUS_TIME_INFO "
                               "WHERE CAR_STATUS_TIME_INFO.locationID = '%1' "
                               "GROUP BY date "
                               "order by date asc")
            .arg(LocationID);
    qDebug()<<sqlquery;
    query.exec(sqlquery);

    while(query.next()){

        Volume_time* vt = new Volume_time(query.value(0).toDateTime(), query.value(1).toInt());
        list.append(QVariant::fromValue(vt));
    }
    return list;
}

QString Car_status_timeController:: calCarTimePeriod(QString PlateID){
    int totalSec = 0;
    int h,m,s;

    QSqlQuery query;
    QString sqlquery = QString("select TIMESTAMPDIFF(SECOND ,intab.intime,outtab.outtime) as totalSec from "
                              " (select time as intime from CAR_STATUS_TIME_INFO where status='I' and plateID='%1' "
                              " order by time desc limit 1)as intab,"
                               "(select time as outtime from CAR_STATUS_TIME_INFO where status='O' and plateID='%1' "
                               "order by time desc limit 1)as outtab;")
            .arg(PlateID);
    qDebug()<<sqlquery;
    query.exec(sqlquery);
    while(query.next()){
        totalSec = query.value(0).toInt();

    }
    h = totalSec/3600;
    totalSec %= 3600;

    m = totalSec/60;
    m %= 60;

    s = totalSec;

    string dateStr = ""+to_string(h)+":"+to_string(m)+":"+to_string(s);
    QString qds = QString::fromStdString(dateStr);
//    qDebug()<<qds;


    return qds;

}


