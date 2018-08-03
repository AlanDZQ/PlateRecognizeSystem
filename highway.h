#ifndef HIGHWAY_H
#define HIGHWAY_H
#include<QDebug>
#include <QString>
#include <QObject>

class Highway : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString getHighwayID READ getHighwayID WRITE setHighwayID NOTIFY changed)
    Q_PROPERTY(QString getDescription READ getDescription WRITE setDescription NOTIFY changed)
    Q_PROPERTY(QString getStartLocationID READ getStartLocationID WRITE setStartLocationID NOTIFY changed)
    Q_PROPERTY(QString getEndLocationID READ getEndLocationID WRITE setEndLocationID NOTIFY changed)





private:
    QString highwayID;
    QString description;
    QString startLocationID;
    QString endLocationID;



public:
    explicit Highway(QObject *parent = 0);
    Highway(QString highwayID,
         QString description,
        QString startLocationID,
        QString endLocationID) : highwayID(highwayID),description(description),startLocationID(startLocationID),endLocationID(endLocationID){}


    void setHighwayID(QString highwayID){
        this->highwayID = highwayID;
    }
    void setDescription(QString description){
        this->description = description;
    }
    void setStartLocationID(QString startLocationID){
        this->startLocationID = startLocationID;
    }
    void setEndLocationID(QString endLocationID){
        this->endLocationID = endLocationID;
    }




    QString getHighwayID(){
        return this->highwayID;
    }
    QString getDescription(){
        return this->description;
    }
    QString getStartLocationID(){
        return this->startLocationID;
    }
    QString getEndLocationID(){
        return this->endLocationID;
    }




signals:
    void changed(QVariant arg);
};
#endif // HIGHWAY_H
