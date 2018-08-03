#ifndef TOLL_TIME_H
#define TOLL_TIME_H
#include<QDebug>
#include <QString>
#include <QObject>
#include <QDateTime>

class Toll_time: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QDateTime getDate READ getDate WRITE setDate NOTIFY changed)
    Q_PROPERTY(double getProfit READ getProfit WRITE setProfit NOTIFY changed)

private:
    QDateTime date;
    double profit;


public:
    explicit Toll_time(QObject *parent = 0);
    Toll_time(QDateTime date,
         double profit
        ) : date(date),profit(profit){}


    void setDate(QDateTime date){
        this->date = date;
    }
    void setProfit(double profit){
        this->profit = profit;
    }


    QDateTime getDate(){
        return this->date;
    }
    double getProfit(){
        return this->profit;
    }



signals:
    void changed(QVariant arg);
};
#endif // TOLL_TIME_H
