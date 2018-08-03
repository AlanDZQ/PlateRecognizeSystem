#ifndef USER_H
#define USER_H
#include<QSqlQuery>
#include<QDebug>
#include <QString>
#include <QObject>

class User : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString getEmail READ getEmail WRITE setEmail NOTIFY changed)
    Q_PROPERTY(QString getPassword READ getPassword WRITE setPassword NOTIFY changed)
    Q_PROPERTY(QString getName READ getName WRITE setName NOTIFY changed)
    Q_PROPERTY(QString getPrivilege READ getPrivilege WRITE setPrivilege NOTIFY changed)
    Q_PROPERTY(QString getUserID READ getUserID WRITE setUserID NOTIFY changed)
    Q_PROPERTY(QString getPhone READ getPhone WRITE setPhone NOTIFY changed)
    Q_PROPERTY(QString getWagecardID READ getWagecardID WRITE setWagecardID NOTIFY changed)
    Q_PROPERTY(QString getGender READ getGender WRITE setGender NOTIFY changed)
    Q_PROPERTY(int getAge READ getAge WRITE setAge NOTIFY changed)
    Q_PROPERTY(float getSalary READ getSalary WRITE setSalary NOTIFY changed)
    Q_PROPERTY(QString getHeadPicURL READ getHeadPicURL WRITE setHeadPicURL NOTIFY changed)

private:

    QString userID;
    QString name;
    QString password;
    QString gender;
    int age;
    double salary;
    QString email;
    QString privilege;
    QString phone;
    QString wagecardID;
    QString headPicURL;


public:
    explicit User(QObject *parent = 0);
    User(QString userID,
         QString password,
         QString name,
         QString gender,
         int age,
         QString privilege,
         double salary,
         QString email,
         QString phone,
         QString wagecardID,
         QString headPicURL) : email(email),password(password),name(name),privilege(privilege),userID(userID),
        phone(phone),wagecardID(wagecardID),gender(gender),age(age),salary(salary),headPicURL(headPicURL){}

    void setEmail(QString email) {
        this->email = email;
    }
    void setPassword(QString password){
        this->password = password;
    }
    void setName(QString name){
        this->name = name;
    }
    void setPrivilege(QString privilege){
        this->privilege = privilege;
    }
    void setUserID(QString userID){
        this->userID = userID;
    }
    void setPhone(QString phone){
        this->phone = phone;
    }
    void setWagecardID(QString wagecardID){
        this->wagecardID = wagecardID;
    }
    void setGender(QString gender){
        this->gender = gender;
    }
    void setAge(int age){
        this->age = age;
    }
    void setSalary(double salary){
        this->salary = salary;
    }
    void setHeadPicURL(QString headPicURL){
        this->headPicURL = headPicURL;
    }


    QString getHeadPicURL(){
        return this->headPicURL;
    }

    QString getEmail(){
        return this->email;
    }
    QString getPassword(){
        return this->password;
    }
    QString getName(){
        return this->name;
    }
    QString getPrivilege(){
        return this->privilege;
    }
    QString getUserID(){
        return this->userID;
    }
    QString getPhone(){
        return this->phone;
    }
    QString getWagecardID(){
        return this->wagecardID;
    }
    QString getGender(){
        return this->gender;
    }
    int getAge(){
        return this->age;
    }
    double getSalary(){
        return this->salary;
    }

signals:
    void changed(QVariant arg);
};
#endif // USER_H
