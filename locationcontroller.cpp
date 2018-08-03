#include "locationcontroller.h"
#include "location.h"
#include <QSqlQuery>
#include <QSqlDatabase>
#include <QDebug>
LocationController::LocationController(QObject *parent){}
LocationController::~LocationController(){}


QList<QVariant> LocationController:: openLocation(){
    QList<QVariant> list = {};
    QSqlQuery query;
    query.exec("SELECT * FROM NEUSOFT2.LOCATION_INFO;");
    while(query.next()){
        Location* location = new Location(query.value(0).toString(), query.value(1).toString(), query.value(2).toDouble(),
                                        query.value(3).toDouble());

        list.append(QVariant::fromValue(location));
    }
    return list;

}

void LocationController:: addLocation(QString locationID,
         QString description,
        double latitude,
        double longitude){

    QSqlQuery query;
    QString sqlquery = QString("insert into NEUSOFT2.LOCATION_INFO values('%1','%2','%3','%4')")
            .arg(locationID,description)
            .arg(latitude)
            .arg(longitude);

    qDebug()<<sqlquery;

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
    query.exec(sqlquery);
    qDebug()<<"addLocation OK"<<endl;
}

void LocationController:: delLocation(QString locationID){
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
    QString sqlquery = QString("DELETE FROM NEUSOFT2.LOCATION_INFO WHERE locationID = '%1' ")
            .arg(locationID);

//    saveOperation(sqlquery);

    query.exec(sqlquery);
    qDebug()<<"delLocation OK"<<endl;

}

void LocationController:: editLocation(QString locationID,
         QString description,
        double latitude,
        double longitude){
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
    QString sqlquery = QString("UPDATE NEUSOFT2.LOCATION_INFO SET description = '%2' , latitude = '%3', longitude = '%4'"
                               "  WHERE locationID = '%1'  ")
            .arg(locationID,description)
            .arg(latitude)
            .arg(longitude);

    qDebug()<<sqlquery<<endl;
//    saveOperation(sqlquery);
    query.exec(sqlquery);
    qDebug()<<"editLocation OK"<<endl;

}

QList<QVariant> LocationController:: searchLocation(QString colName,QString theOne){
    QSqlQuery query;
    QList<QVariant> list = {};
    QString sqlquery = QString("SELECT * FROM NEUSOFT2.LOCATION_INFO WHERE %1 = '%2' ")
            .arg(colName,theOne);
    qDebug()<<sqlquery;
    query.exec(sqlquery);
    while(query.next()){
        Location* location = new Location(query.value(0).toString(), query.value(1).toString(), query.value(2).toDouble(),
                                        query.value(3).toDouble());

        list.append(QVariant::fromValue(location));
    }
    return list;

}

QList<QVariant> LocationController:: sortLocation(QString colName, bool asc){
    if(asc){
        QSqlQuery query;
            QList<QVariant> list = {};
            QString sqlquery = QString("SELECT * FROM NEUSOFT2.LOCATION_INFO ORDER BY %1 asc")
                    .arg(colName);

            query.exec(sqlquery);
            while(query.next()){
                Location* location = new Location(query.value(0).toString(), query.value(1).toString(), query.value(2).toDouble(),
                                                query.value(3).toDouble());

                list.append(QVariant::fromValue(location));
            }
            return list;
    }else{
        QSqlQuery query;
            QList<QVariant> list = {};
            QString sqlquery = QString("SELECT * FROM NEUSOFT2.LOCATION_INFO ORDER BY %1 desc")
                    .arg(colName);

            query.exec(sqlquery);
            while(query.next()){
                Location* location = new Location(query.value(0).toString(), query.value(1).toString(), query.value(2).toDouble(),
                                                query.value(3).toDouble());

                list.append(QVariant::fromValue(location));
            }
            return list;
    }

}

