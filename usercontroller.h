#ifndef USERCONTROLLER_H
#define USERCONTROLLER_H

#include <QObject>
#include <QList>


class UserController : public QObject
{
    Q_OBJECT

public:
    explicit UserController(QObject *parent = 0);
    ~UserController();

public slots:
    QList<QVariant> openUser();

    void addUser(QString userID,
                     QString password,
                     QString name,
                     QString gender,
                     QString age,
                     QString privilege,
                     QString salary,
                     QString email,
                     QString phone,
                     QString wagecardID,
                     QString pic);

    void delUser(QString UserID);

    void editUser(QString userID,
                  QString password,
                  QString name,
                  QString gender,
                  QString age,
                  QString privilege,
                  QString salary,
                  QString email,
                  QString phone,
                  QString wagecardID,
                  QString pic);


    QList<QVariant> searchUser(QString colName,QString theOne);

    QList<QVariant> sortUser(QString colName, bool asc = true );


};

#endif // USERCONTROLLER_H
