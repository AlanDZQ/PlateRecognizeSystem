#ifndef CAR_H
#define CAR_H
#include<QDebug>
#include <QString>
#include <QObject>

class Car : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString getPlateID READ getPlateID WRITE setPlateID NOTIFY changed)
    Q_PROPERTY(QString getType READ getType WRITE setType NOTIFY changed)
    Q_PROPERTY(QString getOwnerName READ getOwnerName WRITE setOwnerName NOTIFY changed)
    Q_PROPERTY(QString getOwnerID READ getOwnerID WRITE setOwnerID NOTIFY changed)
    Q_PROPERTY(QString getOwnerPhone READ getOwnerPhone WRITE setOwnerPhone NOTIFY changed)
    Q_PROPERTY(QString getOwnerAddress READ getOwnerAddress WRITE setOwnerAddress NOTIFY changed)




private:
    QString plateID;
    QString type;
    QString ownerName;
    QString ownerID;
    QString ownerPhone;
    QString ownerAddress;



public:
    explicit Car(QObject *parent = 0);
    Car(QString plateID,
         QString type,
        QString ownerName,
        QString ownerID,
        QString ownerPhone,
        QString ownerAddress) : plateID(plateID),type(type),ownerName(ownerName),ownerID(ownerID),
        ownerPhone(ownerPhone),ownerAddress(ownerAddress){}


    void setPlateID(QString plateID){
        this->plateID = plateID;
    }
    void setType(QString type){
        this->type = type;
    }
    void setOwnerName(QString ownerName){
        this->ownerName = ownerName;
    }
    void setOwnerID(QString ownerID){
        this->ownerID = ownerID;
    }
    void setOwnerPhone(QString ownerPhone){
        this->ownerPhone = ownerPhone;
    }
    void setOwnerAddress(QString ownerAddress){
        this->ownerAddress = ownerAddress;
    }



    QString getPlateID(){
        return this->plateID;
    }
    QString getType(){
        return this->type;
    }
    QString getOwnerName(){
        return this->ownerName;
    }
    QString getOwnerID(){
        return this->ownerID;
    }
    QString getOwnerPhone(){
        return this->ownerPhone;
    }
    QString getOwnerAddress(){
        return this->ownerAddress;
    }



signals:
    void changed(QVariant arg);
};
#endif // CAR_H
