#ifndef LOCATION_HIGHWAY_H
#define LOCATION_HIGHWAY_H
#include<QDebug>
#include <QString>
#include <QObject>

class Location_highway: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString getLocationID READ getLocationID WRITE setLocationID NOTIFY changed)
    Q_PROPERTY(QString getHighwayID READ getHighwayID WRITE setHighwayID NOTIFY changed)
    Q_PROPERTY(double getDistance READ getDistance WRITE setDistance NOTIFY changed)


private:
    QString locationID;
    QString highwayID;
    double distance;



public:
    explicit Location_highway(QObject *parent = 0);
    Location_highway(QString locationID,
         QString highwayID,
        double distance
        ) : locationID(locationID),highwayID(highwayID),distance(distance){}


    void setLocationID(QString locationID){
        this->locationID = locationID;
    }
    void setHighwayID(QString highwayID){
        this->highwayID = highwayID;
    }
    void setDistance(double distance){
        this->distance = distance;
    }



    QString getLocationID(){
        return this->locationID;
    }
    QString getHighwayID(){
        return this->highwayID;
    }
    double getDistance(){
        return this->distance;
    }




signals:
    void changed(QVariant arg);
};


#endif // LOCATION_HIGHWAY_H
