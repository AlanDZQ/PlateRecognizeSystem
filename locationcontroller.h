#ifndef LOCATIONCONTROLLER_H
#define LOCATIONCONTROLLER_H

#include <QObject>
#include <QList>


class LocationController : public QObject
{
    Q_OBJECT

public:
    explicit LocationController(QObject *parent = 0);
    ~LocationController();

public slots:
    QList<QVariant> openLocation();

    void addLocation(QString locationID,
         QString description,
        double latitude,
        double longitude);

    void delLocation(QString locationID);

    void editLocation(QString locationID,
         QString description,
        double latitude,
        double longitude);

    QList<QVariant> searchLocation(QString colName,QString theOne);

    QList<QVariant> sortLocation(QString colName, bool asc = true );


};
#endif // LOCATIONCONTROLLER_H
