#include "usercontroller.h"
#include "user.h"
#include <QSqlQuery>
#include <QSqlDatabase>
#include <QDebug>
UserController::UserController(QObject *parent){}
UserController::~UserController(){}


QList<QVariant> UserController::openUser(){
    QList<QVariant> list = {};
    QSqlQuery query;
    query.exec("SELECT * FROM NEUSOFT2.USER_INFO;");
    while(query.next()){
        User* user = new User(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                              query.value(3).toString(), query.value(4).toInt(), query.value(5).toString(),
                              query.value(6).toDouble(), query.value(7).toString(), query.value(8).toString(),
                              query.value(9).toString(),query.value(10).toString());

        list.append(QVariant::fromValue(user));
    }
    return list;

}

void UserController:: addUser(QString userID,
                              QString password,
                              QString name,
                              QString gender,
                              QString age,
                              QString privilege,
                              QString salary,
                              QString email,
                              QString phone,
                              QString wagecardID,
                              QString pic){

    QSqlQuery query;
    QString sqlquery = QString("insert into NEUSOFT2.USER_INFO values('%1','%2','%3','%4','%5','%6','%7','%8','%9','%10','%11)")
            .arg(userID,password,name,gender)
            .arg(age)
            .arg(privilege)
            .arg(salary)
            .arg(email,phone,wagecardID,pic);

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
    qDebug()<<"addUser OK"<<endl;
}

void UserController:: delUser(QString UserID){
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
    QString sqlquery = QString("DELETE FROM NEUSOFT2.USER_INFO WHERE USERID = '%1' ")
            .arg(UserID);

    //    saveOperation(sqlquery);

    query.exec(sqlquery);
    qDebug()<<"delUser OK"<<endl;

}

void UserController:: editUser(QString userID,
                               QString password,
                               QString name,
                               QString gender,
                               QString age,
                               QString privilege,
                               QString salary,
                               QString email,
                               QString phone,
                               QString wagecardID,
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
    QString sqlquery = QString("UPDATE NEUSOFT2.USER_INFO SET password = '%2' "
                               ", name = '%3', gender = '%4', age = '%5', privilege = '%6'"
                               ", salary = '%7', email = '%8' , phone = '%9' , wagecardID = '%10', headpicurl = '%11'  WHERE userID = '%1'")
            .arg(userID,password,name,gender)
            .arg(age)
            .arg(privilege)
            .arg(salary)
            .arg(email,phone,wagecardID,pic);

    //    qDebug()<<sqlquery<<endl;
    //    saveOperation(sqlquery);
    query.exec(sqlquery);
    qDebug()<<"editUser OK"<<endl;

}

QList<QVariant> UserController:: searchUser(QString colName,QString theOne){
    QSqlQuery query;
    QList<QVariant> list = {};
    QString sqlquery = QString("SELECT * FROM NEUSOFT2.USER_INFO WHERE %1 = '%2' ")
            .arg(colName,theOne);
    qDebug()<<sqlquery;
    query.exec(sqlquery);
    while(query.next()){
        User* user = new User(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                              query.value(3).toString(), query.value(4).toInt(), query.value(5).toString(),
                              query.value(6).toDouble(), query.value(7).toString(), query.value(8).toString(),
                              query.value(9).toString(),query.value(10).toString());

        list.append(QVariant::fromValue(user));
    }
    return list;

}

QList<QVariant> UserController:: sortUser(QString colName, bool asc){
    if(asc){
        QSqlQuery query;
        QList<QVariant> list = {};
        QString sqlquery = QString("SELECT * FROM NEUSOFT2.USER_INFO ORDER BY %1 asc")
                .arg(colName);

        query.exec(sqlquery);
        while(query.next()){
            User* user = new User(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                  query.value(3).toString(), query.value(4).toInt(), query.value(5).toString(),
                                  query.value(6).toDouble(), query.value(7).toString(), query.value(8).toString(),
                                  query.value(9).toString(),query.value(10).toString());

            list.append(QVariant::fromValue(user));
        }
        return list;
    }else{
        QSqlQuery query;
        QList<QVariant> list = {};
        QString sqlquery = QString("SELECT * FROM NEUSOFT2.USER_INFO ORDER BY %1 desc")
                .arg(colName);

        query.exec(sqlquery);
        while(query.next()){
            User* user = new User(query.value(0).toString(), query.value(1).toString(), query.value(2).toString(),
                                  query.value(3).toString(), query.value(4).toInt(), query.value(5).toString(),
                                  query.value(6).toDouble(), query.value(7).toString(), query.value(8).toString(),
                                  query.value(9).toString(),query.value(10).toString());

            list.append(QVariant::fromValue(user));
        }
        return list;

    }
}


