#include "highwaycontroller.h"
#include "highway.h"
#include <QSqlQuery>
#include <QSqlDatabase>
#include <QDebug>
HighwayController::HighwayController(QObject *parent){}
HighwayController::~HighwayController(){}


QList<QVariant> HighwayController:: openHighway(){
    QList<QVariant> list = {};
    QSqlQuery query;
    query.exec("SELECT * FROM NEUSOFT2.HIGHWAY_INFO;");
    while(query.next()){
        Highway* highway = new Highway(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                        query.value(3).toString());

        list.append(QVariant::fromValue(highway));
    }
    return list;

}

void HighwayController:: addHighway(QString highwayID,
         QString description,
        QString startLocationID,
        QString endLocationID){

    QSqlQuery query;
    QString sqlquery = QString("insert into NEUSOFT2.HIGHWAY_INFO values('%1','%2','%3','%4')")
            .arg(highwayID,description,startLocationID,endLocationID);

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
    qDebug()<<"addHighway OK"<<endl;
}

void HighwayController:: delHighway(QString highwayID){
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
    QString sqlquery = QString("DELETE FROM NEUSOFT2.HIGHWAY_INFO WHERE highwayID = '%1' ")
            .arg(highwayID);

//    saveOperation(sqlquery);

    query.exec(sqlquery);
    qDebug()<<"delHighway OK"<<endl;

}

void HighwayController:: editHighway(QString highwayID,
        QString description,
        QString startLocationID,
        QString endLocationID){
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
    QString sqlquery = QString("UPDATE NEUSOFT2.HIGHWAY_INFO SET description = '%2' , startLocationID = '%3', endLocationID = '%4'"
                               " WHERE plateID = '%1'  ")
            .arg(highwayID,description,startLocationID,endLocationID);

//    qDebug()<<sqlquery<<endl;
//    saveOperation(sqlquery);
    query.exec(sqlquery);
    qDebug()<<"editHighway OK"<<endl;

}

QList<QVariant> HighwayController:: searchHighway(QString colName,QString theOne){
    QSqlQuery query;
    QList<QVariant> list = {};
    QString sqlquery = QString("SELECT * FROM NEUSOFT2.HIGHWAY_INFO WHERE %1 = '%2' ")
            .arg(colName,theOne);
//    qDebug()<<sqlquery;
    query.exec(sqlquery);
    while(query.next()){
        Highway* highway = new Highway(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                        query.value(3).toString());

        list.append(QVariant::fromValue(highway));
    }
    return list;

}

QList<QVariant> HighwayController:: sortHighway(QString colName, bool asc){
    if(asc){
        QSqlQuery query;
            QList<QVariant> list = {};
            QString sqlquery = QString("SELECT * FROM NEUSOFT2.HIGHWAY_INFO ORDER BY %1 asc")
                    .arg(colName);

            query.exec(sqlquery);
            while(query.next()){
                Highway* highway = new Highway(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                                query.value(3).toString());

                list.append(QVariant::fromValue(highway));
            }
            return list;
    }else{
        QSqlQuery query;
            QList<QVariant> list = {};
            QString sqlquery = QString("SELECT * FROM NEUSOFT2.HIGHWAY_INFO ORDER BY %1 desc")
                    .arg(colName);

            query.exec(sqlquery);
            while(query.next()){
                Highway* highway = new Highway(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                                query.value(3).toString());

                list.append(QVariant::fromValue(highway));
            }
            return list;
    }

}
