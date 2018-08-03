#ifndef CARCONTROLLER_H
#define CARCONTROLLER_H

#include <QObject>
#include <QList>


class CarController : public QObject
{
    Q_OBJECT

public:
    explicit CarController(QObject *parent = 0);
    ~CarController();

public slots:
    QList<QVariant> openCar();

    void addCar(QString plateID,
                QString type,
               QString ownerName,
               QString ownerID,
               QString ownerPhone,
               QString ownerAddress);

    void delCar(QString plateID);

    void editCar(QString plateID,
                 QString type,
                 QString ownerName,
                 QString ownerID,
                 QString ownerPhone,
                 QString ownerAddress);

    QList<QVariant> searchCar(QString colName,QString theOne);

    QList<QVariant> sortCar(QString colName, bool asc = true );


};
#endif // CARCONTROLLER_H
