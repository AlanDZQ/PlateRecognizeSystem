#ifndef FINANCECONTROLLER_H
#define FINANCECONTROLLER_H

#include <QObject>
#include <QList>


class FinanceController : public QObject
{
    Q_OBJECT

public:
    explicit FinanceController(QObject *parent = 0);
    ~FinanceController();

public slots:
    QList<QVariant> openFinance();

    void addFinance(QString cserialID,
    double cost);

    void delFinance(QString fserialID);

    void editFinance(QString fserialID,
    QString cserialID,
    double cost);

    QList<QVariant> searchFinance(QString colName, QString theOne);

    QList<QVariant> sortFinance(QString colName, bool asc = true );


};

#endif // FINANCECONTROLLER_H
