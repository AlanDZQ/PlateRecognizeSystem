#include "excelconnection.h"

Excelconnection::Excelconnection(QObject *parent){}
Excelconnection::~Excelconnection(){}

QString Excelconnection::dbtoExcel(int id,QString path){
    QString sql;
    int len;
    Document d;
    switch (id) {
    case 8:
        sql=QString::fromLocal8Bit("SELECT * FROM NEUSOFT2.USER_INFO;");
        d.write(1,1,"userID");
        d.write(1,2,"password");
        d.write(1,3,"name");
        d.write(1,4,"gender");
        d.write(1,5,"age");
        d.write(1,6,"privilege");
        d.write(1,7,"salary");
        d.write(1,8,"email");
        d.write(1,9,"phone");
        d.write(1,10,"wagecardID");
        d.write(1,11,"headPicURL");
        len=11;
        break;

    default:
        break;
    }
    QSqlQuery query;
    query.exec(sql);
    int row=0;
    while(query.next()){
        row++;
        for (int col=0;col<len;col++){
            d.write(row+1,col+1,query.value(col));
        }
    }
    time_t timep;
    time (&timep);
    path=path+".xlsx";
    path = path.right(path.length()-7);
    qDebug()<<path;
    d.saveAs(path);
    return path;
}

QList<QList<QVariant>> Excelconnection::readExcel(QString path){
    qDebug()<<path;
    Document xlsx(path);
    QList<QList<QVariant>> l;
    for(int row=2;true;++row){
        Cell *tem=xlsx.cellAt(row,1);
        if(tem==NULL)
            break;
        QList<QVariant> teml;
        for(int col=1;true;++col){
            Cell* cell=xlsx.cellAt(row,col);
            if(cell==NULL)
                break;
            teml.append(cell->readValue());
        }
        l.append(teml);
    }
    return l;
}

QList<QVariant> Excelconnection::openUserinfo(QString path){
    QList<QList<QVariant>> l;
    path = path.right(path.length()-7);
    l=this->readExcel(path);
    QList<QVariant> list = {};
    for (int i =0;i<l.length();i++){
        qDebug()<<l.at(i);
        User* user = new User(l.at(i).at(0).toString(), l.at(i).at(1).toString(), l.at(i).at(2).toString(),
                                        l.at(i).at(3).toString(), l.at(i).at(4).toInt(), l.at(i).at(5).toString(),
                                        l.at(i).at(6).toFloat(), l.at(i).at(7).toString(), l.at(i).at(8).toString(),
                                        l.at(i).at(9).toString(),l.at(i).at(10).toString());
        list.append(QVariant::fromValue(user));
    }
    return list;
}

void Excelconnection::saveUserinfo(QString path){
    QList<QList<QVariant>> l;
    path = path.right(path.length()-7);
    l=this->readExcel(path);
    for(int i=0;i<l.length();i++){
        QSqlQuery query;
        QString sqlquery = QString("replace into USER_INFO(userID,password,name,gender,age,privilege,salary,email,phone,wagecardID,headPicURL)"
                                   "values('%1','%2','%3','%4','%5','%6','%7','%8','%9','%10','%11')")
                .arg(l.at(i).at(0).toString(),l.at(i).at(1).toString(),l.at(i).at(2).toString())
                 .arg(l.at(i).at(3).toString(),l.at(i).at(4).toString(),l.at(i).at(5).toString(),
                     l.at(i).at(6).toString(),l.at(i).at(7).toString(),l.at(i).at(8).toString(),
                     l.at(i).at(9).toString(),l.at(i).at(10).toString());
        query.exec(sqlquery);
    }
}
