#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtSql>
#include <QTextToSpeech>
#include "car.h"
#include "car_status_time.h"
#include "car_status_timecontroller.h"
#include "carcontroller.h"
#include "dbloader.h"
#include "finance.h"
#include "financecontroller.h"
#include "highway.h"
#include "highwaycontroller.h"
#include "location.h"
#include "location_highway.h"
#include "location_highwaycontroller.h"
#include "locationcontroller.h"
#include "qkuploadfile.h"
#include "user.h"
#include "usercontroller.h"
#include "platerecognize.h"
#include "speakitem.h"
#include "imageprovider.h"
#include "QQmlContext"
#include "excelconnection.h"
#include "pdfgenerate.h"

int main(int argc, char *argv[])
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("59.110.240.50");
    db.setPort(3306);
    db.setDatabaseName("NEUSOFT2");
    db.setUserName("qiqi");
    db.setPassword("123456");
    bool ok = db.open();
    if(ok){
        qDebug()<<"Database open";
    }else{
        qDebug()<<"Database error";
    }


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    qmlRegisterType<PlateRecognize>("PlateRecognize",1,0,"PlateRecognize");
    qmlRegisterType<SpeakItem>("SpeakItem",1,0,"SpeakItem");
    qmlRegisterType<CarController>("CarController",1,0,"CarController");
    qmlRegisterType<Car_status_timeController>("Car_status_timeController",1,0,"Car_status_timeController");
    qmlRegisterType<FinanceController>("FinanceController",1,0,"FinanceController");
    qmlRegisterType<HighwayController>("HighwayController",1,0,"HighwayController");
    qmlRegisterType<Location_highwayController>("Location_highwayController",1,0,"Location_highwayController");
    qmlRegisterType<LocationController>("LocationController",1,0,"LocationController");
    qmlRegisterType<UserController>("UserController",1,0,"UserController");
    qmlRegisterType<Excelconnection>("Excelconnection",1,0,"Excelconnection");
    qmlRegisterType<Pdfgenerate>("Pdfgenerate",1,0,"Pdfgenerate");

    QQmlApplicationEngine engine;

//    ShowImage *CodeImage = new ShowImage();

//    engine.rootContext()->setContextProperty("CodeImage",CodeImage);
//    engine.addImageProvider(QLatin1String("CodeImg"), CodeImage->m_pImgProvider);

    engine.addImageProvider(QLatin1String("imageProvider"), new ImageProvider);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
