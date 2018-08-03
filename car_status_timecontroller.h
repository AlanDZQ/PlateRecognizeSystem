#ifndef CAR_STATUS_TIMECONTROLLER_H
#define CAR_STATUS_TIMECONTROLLER_H

#include <QObject>
#include <QList>
#include <QDateTime>


class Car_status_timeController : public QObject
{
    Q_OBJECT

public:
    explicit Car_status_timeController(QObject *parent = 0);
    ~Car_status_timeController();

public slots:
    QList<QVariant> openCar_status_time();

    void addCar_status_time(QString plateID,
    QString status,
    QString locationID,
    QString time,
    QString pic);

    int findLastC(QString plateID,QString time);

    void delCar_status_time(QString cserialID);

    void editCar_status_time(QString cserialID,
    QString plateID,
    QString status,
    QString locationID,
    QString time,
    QString pic);

    QList<QVariant> searchCar_status_time(QString colName,QString theOne);
    QList<QVariant> sortCar_status_time(QString colName, bool asc = true );

    QList<QVariant> calToll_time(QString LocationID);

    QList<QVariant> calVolume_time(QString LocationID);

    QString calCarTimePeriod(QString PlateID);


};
#endif // CAR_STATUS_TIMECONTROLLER_H
