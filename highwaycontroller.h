#ifndef HIGHWAYCONTROLLER_H
#define HIGHWAYCONTROLLER_H


#include <QObject>
#include <QList>


class HighwayController : public QObject
{
    Q_OBJECT

public:
    explicit HighwayController(QObject *parent = 0);
    ~HighwayController();

public slots:
    QList<QVariant> openHighway();

    void addHighway(QString highwayID,
         QString description,
        QString startLocationID,
        QString endLocationID);

    void delHighway(QString highwayID);

    void editHighway(QString highwayID,
         QString description,
        QString startLocationID,
        QString endLocationID);

    QList<QVariant> searchHighway(QString colName,QString theOne);

    QList<QVariant> sortHighway(QString colName, bool asc = true );


};

#endif // HIGHWAYCONTROLLER_H
