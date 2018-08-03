#ifndef CAR_STATUS_TIME_H
#define CAR_STATUS_TIME_H
#include<QDebug>
#include <QString>
#include <QObject>
#include <QDateTime>

class Car_status_time : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString getCserialID READ getCserialID WRITE setCserialID NOTIFY changed)
    Q_PROPERTY(QString getPlateID READ getPlateID WRITE setPlateID NOTIFY changed)
    Q_PROPERTY(QString getStatus READ getStatus WRITE setStatus NOTIFY changed)
    Q_PROPERTY(QString getLocationID READ getLocationID WRITE setLocationID NOTIFY changed)
    Q_PROPERTY(QDateTime getTime READ getTime WRITE setTime NOTIFY changed)
    Q_PROPERTY(QString getPic READ getPic WRITE setPic NOTIFY changed)




private:
    QString cserialID;
    QString plateID;
    QString status;
    QString locationID;
    QDateTime time;
    QString pic;



public:
    explicit Car_status_time(QObject *parent = 0);
    Car_status_time(QString cserialID,
         QString plateID,
        QString status,
        QString locationID,
        QDateTime time,
        QString pic) : cserialID(cserialID),plateID(plateID),status(status),locationID(locationID),
        time(time),pic(pic){}


    void setCserialID(QString cserialID){
        this->cserialID = cserialID;
    }
    void setPlateID(QString plateID){
        this->plateID = plateID;
    }
    void setStatus(QString status){
        this->status = status;
    }
    void setLocationID(QString locationID){
        this->locationID = locationID;
    }
    void setTime(QDateTime time){
        this->time = time;
    }
    void setPic(QString pic){
        this->pic = pic;
    }



    QString getCserialID(){
        return this->cserialID;
    }
    QString getPlateID(){
        return this->plateID;
    }
    QString getStatus(){
        return this->status;
    }
    QString getLocationID(){
        return this->locationID;
    }
    QDateTime getTime(){
        return this->time;
    }
    QString getPic(){
        return this->pic;
    }



signals:
    void changed(QVariant arg);
};
#endif // CAR_STATUS_TIME_H
