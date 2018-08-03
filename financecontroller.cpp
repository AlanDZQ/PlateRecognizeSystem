#include "financecontroller.h"
#include "finance.h"
#include <QSqlQuery>
#include <QSqlDatabase>
#include <QDebug>
FinanceController::FinanceController(QObject *parent){}
FinanceController::~FinanceController(){}


QList<QVariant> FinanceController:: openFinance(){
    QList<QVariant> list = {};
    QSqlQuery query;
    query.exec("SELECT * FROM NEUSOFT2.FINANCE_INFO;");
    while(query.next()){
        Finance* finance = new Finance(query.value(0).toString(), query.value(1).toString(), query.value(2).toDouble());

        list.append(QVariant::fromValue(finance));
    }
    return list;

}

void FinanceController:: addFinance(QString cserialID,
                                    double cost){

    QSqlQuery query;
    QString sqlquery = QString("insert into NEUSOFT2.FINANCE_INFO (`cserialID`, `cost`) values('%1','%2')")
            .arg(cserialID).arg(cost);
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
    qDebug()<<"addFinance OK"<<endl;
}

void FinanceController:: delFinance(QString fserialID){
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
    QString sqlquery = QString("DELETE FROM NEUSOFT2.FINANCE_INFO WHERE fserialID = '%1' ")
            .arg(fserialID);

//    saveOperation(sqlquery);

    query.exec(sqlquery);
    qDebug()<<"delFinance OK"<<endl;

}

void FinanceController:: editFinance(QString fserialID,
                                     QString cserialID,
                                     double cost){
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
    QString sqlquery = QString("UPDATE NEUSOFT2.FINANCE_INFO SET cserialID = '%2' , cost = %3 WHERE fserialID = '%1'  ")
            .arg(fserialID,cserialID).arg(cost);

//    qDebug()<<sqlquery<<endl;
//    saveOperation(sqlquery);
    query.exec(sqlquery);
    qDebug()<<"editCar OK"<<endl;

}

QList<QVariant> FinanceController:: searchFinance(QString colName,QString theOne){
    QSqlQuery query;
    QList<QVariant> list = {};
    QString sqlquery = QString("SELECT * FROM NEUSOFT2.FINANCE_INFO WHERE %1 = '%2' ")
            .arg(colName,theOne);
    qDebug()<<sqlquery;
    query.exec(sqlquery);
    while(query.next()){
        Finance* finance = new Finance(query.value(0).toString(), query.value(1).toString(), query.value(2).toDouble());

        list.append(QVariant::fromValue(finance));
    }
    return list;


}

QList<QVariant> FinanceController:: sortFinance(QString colName, bool asc){
    if(asc){
        QSqlQuery query;
            QList<QVariant> list = {};
            QString sqlquery = QString("SELECT * FROM NEUSOFT2.FINANCE_INFO ORDER BY %1 asc")
                    .arg(colName);

            query.exec(sqlquery);
            while(query.next()){
                Finance* finance = new Finance(query.value(0).toString(), query.value(1).toString(), query.value(2).toDouble());

                list.append(QVariant::fromValue(finance));
            }
            return list;


    }else{
        QSqlQuery query;
            QList<QVariant> list = {};
            QString sqlquery = QString("SELECT * FROM NEUSOFT2.FINANCE_INFO ORDER BY %1 desc")
                    .arg(colName);

            query.exec(sqlquery);
            while(query.next()){
                Finance* finance = new Finance(query.value(0).toString(), query.value(1).toString(), query.value(2).toDouble());

                list.append(QVariant::fromValue(finance));
            }
            return list;

    }

}
