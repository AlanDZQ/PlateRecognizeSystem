#include "CarController.h"
#include "car.h"
#include <QSqlQuery>
#include <QSqlDatabase>
#include <QDebug>
CarController::CarController(QObject *parent){}
CarController::~CarController(){}


QList<QVariant> CarController:: openCar(){
    QList<QVariant> list = {};
    QSqlQuery query;
    query.exec("SELECT * FROM NEUSOFT2.CAR_INFO;");
    while(query.next()){
        Car* car = new Car(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                        query.value(3).toString(), query.value(4).toString(),
                                        query.value(5).toString());

        list.append(QVariant::fromValue(car));
    }
    return list;

}

void CarController:: addCar(QString plateID,
                            QString type,
                            QString ownerName,
                            QString ownerID,
                            QString ownerPhone,
                            QString ownerAddress){

    QSqlQuery query;
    QString sqlquery = QString("insert into NEUSOFT2.CAR_INFO values('%1','%2','%3','%4','%5','%6')")
            .arg(plateID,type,ownerName,ownerID)
            .arg(ownerPhone)
            .arg(ownerAddress);
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
    qDebug()<<"addCar OK"<<endl;
}

void CarController:: delCar(QString plateID){
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
    QString sqlquery = QString("DELETE FROM NEUSOFT2.CAR_INFO WHERE plateID = '%1' ")
            .arg(plateID);

//    saveOperation(sqlquery);

    query.exec(sqlquery);
    qDebug()<<"delCar OK"<<endl;

}

void CarController:: editCar(QString plateID,
                              QString type,
                              QString ownerName,
                              QString ownerID,
                              QString ownerPhone,
                              QString ownerAddress){
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
    QString sqlquery = QString("UPDATE NEUSOFT2.CAR_INFO SET type = '%2' , ownerName = '%3', ownerID = '%4'"
                               ", ownerPhone = '%5', ownerAddress = '%6' WHERE plateID = '%1'  ")
            .arg(plateID,type,ownerName,ownerID)
            .arg(ownerPhone)
            .arg(ownerAddress);

//    qDebug()<<sqlquery<<endl;
//    saveOperation(sqlquery);
    query.exec(sqlquery);
    qDebug()<<"editCar OK"<<endl;

}

QList<QVariant> CarController:: searchCar(QString colName,QString theOne){
    QSqlQuery query;
    QList<QVariant> list = {};
    QString sqlquery = QString("SELECT * FROM NEUSOFT2.CAR_INFO WHERE %1 = '%2' ")
            .arg(colName,theOne);
    qDebug()<<sqlquery;
    query.exec(sqlquery);
    while(query.next()){
        Car* car = new Car(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                        query.value(3).toString(), query.value(4).toString(),
                                        query.value(5).toString());

        list.append(QVariant::fromValue(car));
    }
    return list;

}

QList<QVariant> CarController:: sortCar(QString colName, bool asc){
    if(asc){
        QSqlQuery query;
            QList<QVariant> list = {};
            QString sqlquery = QString("SELECT * FROM NEUSOFT2.CAR_INFO ORDER BY %1 asc")
                    .arg(colName);

            query.exec(sqlquery);
            while(query.next()){
                Car* car = new Car(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                                query.value(3).toString(), query.value(4).toString(),
                                                query.value(5).toString());

                list.append(QVariant::fromValue(car));
            }
            return list;
    }else{
        QSqlQuery query;
            QList<QVariant> list = {};
            QString sqlquery = QString("SELECT * FROM NEUSOFT2.CAR_INFO ORDER BY %1 desc")
                    .arg(colName);

            query.exec(sqlquery);
            while(query.next()){
                Car* car = new Car(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                                query.value(3).toString(), query.value(4).toString(),
                                                query.value(5).toString());

                list.append(QVariant::fromValue(car));
            }
            return list;
    }

}
