#ifndef LOCATION_H
#define LOCATION_H

#include<QDebug>
#include <QString>
#include <QObject>

class Location : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString getLocationID READ getLocationID WRITE setLocationID NOTIFY changed)
    Q_PROPERTY(QString getDescription READ getDescription WRITE setDescription NOTIFY changed)
    Q_PROPERTY(double getLatitude READ getLatitude WRITE setLatitude NOTIFY changed)
    Q_PROPERTY(double getLongitude READ getLongitude WRITE setLongitude NOTIFY changed)


private:
    QString locationID;
    QString description;
    double latitude;
    double longitude;



public:
    explicit Location(QObject *parent = 0);
    Location(QString locationID,
         QString description,
        double latitude,
        double longitude) : locationID(locationID),description(description),latitude(latitude),longitude(longitude){}


    void setLocationID(QString locationID){
        this->locationID = locationID;
    }
    void setDescription(QString description){
        this->description = description;
    }
    void setLatitude(double latitude){
        this->latitude = latitude;
    }
    void setLongitude(double longitude){
        this->longitude = longitude;
    }




    QString getLocationID(){
        return this->locationID;
    }
    QString getDescription(){
        return this->description;
    }
    double getLatitude(){
        return this->latitude;
    }
    double getLongitude(){
        return this->longitude;
    }




signals:
    void changed(QVariant arg);
};
#endif // LOCATION_H
