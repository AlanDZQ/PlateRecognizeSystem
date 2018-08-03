#ifndef FINANCE_H
#define FINANCE_H
#include<QDebug>
#include <QString>
#include <QObject>
#include <QDateTime>

class Finance : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString getFserialID READ getFserialID WRITE setFserialID NOTIFY changed)
    Q_PROPERTY(QString getCserialID READ getCserialID WRITE setCserialID NOTIFY changed)
    Q_PROPERTY(double getCost READ getCost WRITE setCost NOTIFY changed)


private:
    QString fserialID;
    QString cserialID;
    double cost;



public:
    explicit Finance(QObject *parent = 0);
    Finance(QString fserialID,
         QString cserialID,
        double cost
        ) : fserialID(fserialID),cserialID(cserialID),cost(cost){}


    void setCserialID(QString cserialID){
        this->cserialID = cserialID;
    }
    void setFserialID(QString fserialID){
        this->fserialID = fserialID;
    }
    void setCost(double cost){
        this->cost = cost;
    }



    QString getCserialID(){
        return this->cserialID;
    }
    QString getFserialID(){
        return this->fserialID;
    }
    double getCost(){
        return this->cost;
    }




signals:
    void changed(QVariant arg);
};

#endif // FINANCE_H
