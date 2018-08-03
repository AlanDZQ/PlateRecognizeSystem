#include "location_highwaycontroller.h"
#include "Location_highway.h"
#include "location.h"
#include "path.h"
#include <QSqlQuery>
#include <QSqlDatabase>
#include <QDebug>

Location_highwayController::Location_highwayController(QObject *parent){}
Location_highwayController::~Location_highwayController(){}


QList<QVariant> Location_highwayController:: openLocation_highway(){
    QList<QVariant> list = {};
    QSqlQuery query;
    query.exec("SELECT * FROM NEUSOFT2.Location_highway_INFO;");
    while(query.next()){
        Location_highway* location_highway = new Location_highway(query.value(0).toString(), query.value(1).toString(),
         query.value(2).toDouble());

        list.append(QVariant::fromValue(location_highway));
    }
    return list;

}

void Location_highwayController:: addLocation_highway(QString locationID,
         QString highwayID,
        double distance){

    QSqlQuery query;
    QString sqlquery = QString("insert into NEUSOFT2.Location_highway_INFO values('%1','%2','%3')")
            .arg(locationID,highwayID)
            .arg(distance);

    qDebug()<<sqlquery;

    //    saveOperation(sqlquery);
    //    undoData.clear();
    //    undoData.append(Location_highwayID);
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
    qDebug()<<"addLocation_highway OK"<<endl;
}

void Location_highwayController:: delLocation_highway(QString locationID,
         QString highwayID){
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
    QString sqlquery = QString("DELETE FROM NEUSOFT2.Location_highway_INFO WHERE locationID = '%1' AND highwayID= '%2' ")
            .arg(locationID,highwayID);

    //    saveOperation(sqlquery);

    query.exec(sqlquery);
    qDebug()<<"delLocation_highway OK"<<endl;

}

void Location_highwayController:: editLocation_highway(QString locationID,
         QString highwayID,
        double distance){
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
    QString sqlquery = QString("UPDATE NEUSOFT2.Location_highway_INFO SET distance = %3 "
                               "WHERE locationID = '%1' AND highwayID= '%2'  ")
            .arg(locationID,highwayID)
            .arg(distance);

    //    qDebug()<<sqlquery<<endl;
    //    saveOperation(sqlquery);
    query.exec(sqlquery);
    qDebug()<<"editLocation_highway OK"<<endl;

}

QList<QVariant> Location_highwayController:: searchLocation_highway(QString colName,QString theOne){
    QSqlQuery query;
    QList<QVariant> list = {};
    QString sqlquery = QString("SELECT * FROM NEUSOFT2.Location_highway_INFO WHERE %1 = '%2' ")
            .arg(colName,theOne);
    qDebug()<<sqlquery;
    query.exec(sqlquery);
   while(query.next()){
        Location_highway* location_highway = new Location_highway(query.value(0).toString(), query.value(1).toString(),
         query.value(2).toDouble());

        list.append(QVariant::fromValue(location_highway));
    }
    return list;

}

QList<QVariant> Location_highwayController:: sortLocation_highway(QString colName, bool asc){
    if(asc){
        QSqlQuery query;
        QList<QVariant> list = {};
        QString sqlquery = QString("SELECT * FROM NEUSOFT2.Location_highway_INFO ORDER BY %1 asc")
                .arg(colName);

        query.exec(sqlquery);
        while(query.next()){
        Location_highway* location_highway = new Location_highway(query.value(0).toString(), query.value(1).toString(),
         query.value(2).toDouble());

        list.append(QVariant::fromValue(location_highway));
    }
    return list;
    }else{
        QSqlQuery query;
        QList<QVariant> list = {};
        QString sqlquery = QString("SELECT * FROM NEUSOFT2.Location_highway_INFO ORDER BY %1 desc")
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

QList<QString> pass;
Path *Location_highwayController::  findpath(QString from,QString to){
    pass.append(to);
    QSqlQuery query;
    bool success = query.exec("SELECT * FROM NEUSOFT2.LOCATION_HIGHWAY_INFO "
                              "where locationID = '"+to+"' and highwayID in "
                              "(SELECT highwayID from LOCATION_HIGHWAY_INFO where locationID='"+from+"');");
    if(!success){
        qDebug() << "123";
    }else{
        if (query.size()==0){
            query.exec("select * from LOCATION_HIGHWAY_INFO where "
                       "locationID in (select locationID from LOCATION_HIGHWAY_INFO "
                       "group by locationID having count(*)>1) and highwayID in "
                       "(select highwayID from LOCATION_HIGHWAY_INFO where locationID "
                       "= '"+to+"')");
            QList<Path*> allre;
            while(query.next()){
                int newloc=query.value(2).toInt();
                QString highwayID=query.value(1).toString();
                QString temto=query.value(0).toString();
                if(-1!=pass.indexOf(temto)){
                    continue;
                }
                Path *p;
                qDebug()<<temto;
                p=findpath(from,temto);
                if(p==NULL)
                    continue;
                else{
                    QSqlQuery query1;
                    success=query1.exec("select distance from LOCATION_HIGHWAY_INFO where locationID='"+to+"' "
                                       "and highwayID='"+highwayID+"'");
                    query1.first();
                    int toloc=query1.value(0).toInt();
                    int len=toloc-newloc;
                    if(len<0)
                        len=-len;
                    p->len+=len;
                    p->path.append(to);
                    allre.append(p);
                }
            }
            if (allre.length()==0)
                return NULL;
            else{
                Path * result=allre.at(0);
                for(int i=1;i<allre.length();i++){
                    if(allre.at(i)->len<result->len)
                        result=allre.at(i);
                }
                return result;
            }
        }else{
            query.first();
            QString highwayID=query.value(1).toString();
            int toloc=query.value(2).toInt();
            success=query.exec("select * from LOCATION_HIGHWAY_INFO where locationID='"+from+"' "
                               "and highwayID='"+highwayID+"'");
            if(query.size()>0){
                query.first();
                int fromloc=query.value(2).toInt();
                int len=toloc-fromloc;
                if(len<0)
                    len=-len;
                Path * result = new Path();
                result->len=len;
                result->path.append(from);
                result->path.append(to);
                return result;
            }
            else{
                return NULL;
            }
        }
    }
}

QVector<QString> Location_highwayController:: findAllLoc(Path* path){
    QVector<QString> allLoc;
    for(int i = 0; i < path->path.size()-1; i ++){
        QSqlQuery query;
        QString sqlquery = QString("select LOCATION_HIGHWAY_INFO.locationID from "
                                   "(select loc1.highwayID as highwayID from "
                                   "(select * from LOCATION_HIGHWAY_INFO where locationID='%1')as loc1,"
                                    "(select * from LOCATION_HIGHWAY_INFO where locationID='%2')as loc2 "
                                    "where loc1.highwayID=loc2.highwayID ) as hw,"
                                    "(select * from LOCATION_HIGHWAY_INFO where locationID='%1' and "
                                    "highwayID in "
                                    "(select loc1.highwayID as highwayID from "
                                    "(select * from LOCATION_HIGHWAY_INFO where locationID='%1')as loc1,"
                                    "(select * from LOCATION_HIGHWAY_INFO where locationID='%2')as loc2 "
                                    "where loc1.highwayID=loc2.highwayID )) as inloc,"
                                    "(select * from LOCATION_HIGHWAY_INFO where locationID='%2' and "
                                    "highwayID in "
                                    "(select loc1.highwayID as highwayID from "
                                    "(select * from LOCATION_HIGHWAY_INFO where locationID='%1')as loc1,"
                                    "(select * from LOCATION_HIGHWAY_INFO where locationID='%2')as loc2 "
                                    "where loc1.highwayID=loc2.highwayID )) as outloc ,"
                                    "LOCATION_HIGHWAY_INFO "
                                    "where LOCATION_HIGHWAY_INFO.highwayID = hw.highwayID "
                                    "and ("
                                    "LOCATION_HIGHWAY_INFO.distance <= inloc.distance and LOCATION_HIGHWAY_INFO.distance>=outloc.distance "
                                    "or "
                                    "LOCATION_HIGHWAY_INFO.distance >= inloc.distance and LOCATION_HIGHWAY_INFO.distance<=outloc.distance "
                                    ")").arg(path->path[i],path->path[i+1]);
//        qDebug()<<sqlquery;
        query.exec(sqlquery);
        while(query.next()){
          allLoc.append(query.value(0).toString());
        }
    }
//       qDebug()<<"here";
//    for(int i = 0; i < allLoc.size(); i ++){
//        qDebug()<<allLoc[i];
//    }
    return allLoc;

}

QList<QVariant> Location_highwayController:: getAllLoc(QVector<QString> allLoc){
    QSqlQuery query;
    QList<QVariant> list = {};
    for(int i = 0; i < allLoc.size(); i ++){
        QString sqlquery = QString("SELECT * FROM NEUSOFT2.LOCATION_INFO WHERE locationID = '%1' ")
                .arg(allLoc[i]);
        qDebug()<<sqlquery;
        query.exec(sqlquery);
        while(query.next()){
             Location* location = new Location(query.value(0).toString(), query.value(1).toString(),
              query.value(2).toDouble(),query.value(3).toDouble());

             list.append(QVariant::fromValue(location));
         }

    }

    return list;

}

QList<QVariant> Location_highwayController:: getAllLocFull(QString plateID, QString endLoc){
    QString inLoc;
    QSqlQuery query;
    QString sqlquery = QString("select locationID from CAR_STATUS_TIME_INFO where status='I' and plateID='%1' "
                               "order by time desc limit 1")
            .arg(plateID);
//        qDebug()<<sqlquery;
    query.exec(sqlquery);
    while(query.next()){
         inLoc = query.value(0).toString();
     }

    //    Location_highwayController *lhc = new Location_highwayController();
    //    Path *path = lhc->findpath("G000101","G121203");

    //    lhc->getAllLoc(lhc->findAllLoc(path));

    return getAllLoc(findAllLoc(findpath(inLoc,endLoc)));

}

double Location_highwayController:: getCost(QString plateID, QString endLoc){

    double len = getLen(plateID,endLoc);
    QString flag = "";
    QSqlQuery query2;
    QString sqlquery2 = QString("select type from CAR_INFO where plateID='%1' ")
            .arg(plateID);
//        qDebug()<<sqlquery2;
    query2.exec(sqlquery2);
    while(query2.next()){
         flag = query2.value(0).toString();
     }
    double cost;
    if(flag == "A"){
        cost = len*0.5;
    }else if(flag =="B"){
        cost = len*0.7;
    }else{
        cost = len*0.8;
    }

    QString str = QString::number(cost, 'f', 2);
    return str.toDouble();
}

double Location_highwayController:: getLen(QString plateID, QString endLoc){
    QString inLoc;
    QSqlQuery query;
    QString sqlquery = QString("select locationID from CAR_STATUS_TIME_INFO where status='I' and plateID='%1' "
                               "order by time desc limit 1")
            .arg(plateID);
//        qDebug()<<sqlquery;
    query.exec(sqlquery);
    while(query.next()){
         inLoc = query.value(0).toString();
     }

    return findpath(inLoc,endLoc)->len;


}

