#ifndef LOCATION_HIGHWAYCONTROLLER_H
#define LOCATION_HIGHWAYCONTROLLER_H
#include <QObject>
#include <QList>
#include "path.h"
#include <QVector>
#include <QString>
using namespace std;
class Location_highwayController : public QObject
{
    Q_OBJECT

public:
    explicit Location_highwayController(QObject *parent = 0);
    ~Location_highwayController();

public slots:
    QList<QVariant> openLocation_highway();

    void addLocation_highway(QString locationID,
         QString highwayID,
        double distance);

    void delLocation_highway(QString locationID,
                             QString highwayID);

    void editLocation_highway(QString locationID,
         QString highwayID,
        double distance);

    QList<QVariant> searchLocation_highway(QString colName,QString theOne);

    QList<QVariant> sortLocation_highway(QString colName, bool asc = true );

    Path * findpath(QString from,QString to);

    QVector<QString> findAllLoc(Path* path);

    QList<QVariant> getAllLoc(QVector<QString> allLoc);

    QList<QVariant> getAllLocFull(QString plateID, QString endLoc);

    double getCost(QString plateID, QString endLoc);

    double getLen(QString plateID, QString endLoc);

};


#endif // LOCATION_HIGHWAYCONTROLLER_H
