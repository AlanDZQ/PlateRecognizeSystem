#ifndef EXCELCONNECTION_H
#define EXCELCONNECTION_H
#include<QString>
#include <QObject>
#include "xlsxdocument.h"
#include "xlsxchartsheet.h"
#include "xlsxcellrange.h"
#include "xlsxchart.h"
#include "xlsxrichstring.h"
#include "xlsxworkbook.h"
#include <QtSql>
#include <QList>
#include <QtSql>
#include <QList>
#include <QString>
#include <QDateTime>
#include "user.h"
using namespace QXlsx;

class Excelconnection : public QObject
{
    Q_OBJECT
public:
    explicit Excelconnection(QObject *parent = 0);
    ~Excelconnection();

public slots:
    QString dbtoExcel(int id,QString path);
    QList<QList<QVariant>> readExcel(QString path);
    QList<QVariant> openUserinfo(QString path);

    void saveUserinfo(QString path);
};

#endif // EXCELCONNECTION_H
