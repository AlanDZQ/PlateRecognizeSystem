#ifndef VOLUME_TIME_H
#define VOLUME_TIME_H
#include<QDebug>
#include <QString>
#include <QObject>
#include <QDateTime>

class Volume_time: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QDateTime getDate READ getDate WRITE setDate NOTIFY changed)
    Q_PROPERTY(int getFlow READ getFlow WRITE setFlow NOTIFY changed)

private:
    QDateTime date;
    int flow;

public:
    explicit Volume_time(QObject *parent = 0);
    Volume_time(QDateTime date,
         int flow
        ) : date(date),flow(flow){}


    void setDate(QDateTime date){
        this->date = date;
    }
    void setFlow(int flow){
        this->flow = flow;
    }


    QDateTime getDate(){
        return this->date;
    }
    int getFlow(){
        return this->flow;
    }



signals:
    void changed(QVariant arg);
};

#endif // VOLUME_TIME_H
