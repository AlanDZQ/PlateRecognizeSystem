#ifndef PLATERECOGNIZE_H
#define PLATERECOGNIZE_H

#include <QObject>
#include "opencv2/core.hpp"
#include "opencv2/highgui.hpp"

class PlateRecognize : public QObject
{
    Q_OBJECT
public:
    explicit PlateRecognize(QObject *parent = nullptr);
    QImage cvMat2QImage(const cv::Mat& mat);

signals:

public slots:
    QList<QString> videoRecognize();
    QList<QString> upPhotoRecognize(QString path);
    QList<QString> upVideoRecognize(QString path);
};

#endif // PLATERECOGNIZE_H
