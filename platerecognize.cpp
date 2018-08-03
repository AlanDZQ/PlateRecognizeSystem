#include "platerecognize.h"
#include <iostream>
#include <string>
#include <sstream>
#include <QString>
#include <QList>
#include <qdebug.h>
#include "include/Pipeline.h"
// OpenCV includes
#include "opencv2/core.hpp"
#include "opencv2/highgui.hpp"

#include "qkuploadfile.h"


using namespace cv;
using namespace std;
const std::string currentPath = "/Users/apple/Documents/QtProjects/NEUSOFT2/";

PlateRecognize::PlateRecognize(QObject *parent) : QObject(parent){}

QList<QString> PlateRecognize::videoRecognize() {
    QDateTime current_date_time = QDateTime::currentDateTime();
    QString current_date = current_date_time.toString("yyyy.MM.dd.hh.mm.ss");
    QList<QString> plateWithPic = {};
    QString plate = "";
    QList<String> plateList;
    QString fileName = "";

    pr::PipelinePR prc(currentPath+"model/cascade.xml",
                       currentPath+"model/HorizonalFinemapping.prototxt", currentPath+"model/HorizonalFinemapping.caffemodel",
                       currentPath+"model/Segmentation.prototxt", currentPath+"model/Segmentation.caffemodel",
                       currentPath+"model/CharacterRecognization.prototxt", currentPath+"model/CharacterRecognization.caffemodel",
                       currentPath+"model/SegmentationFree.prototxt", currentPath+"model/SegmentationFree.caffemodel"
                       );

    String videoFile = "";

    VideoCapture cap; // open the default camera
    if (videoFile != "")
        cap.open(videoFile);
    else
        cap.open(0);
    if (!cap.isOpened()){  // check if we succeeded
        std::cout << "camera not open" << std::endl;
        exit(1);
    }


    cvNamedWindow("Video", 1);
    for (;;) {
        Mat frame;
        cap >> frame; // get a new frame from camera

        //读取下一帧
        if (!cap.read(frame)) {
            std::cout << "读取视频结束" << std::endl;
            break;
        }

        std::vector<pr::PlateInfo> res = prc.RunPiplineAsImage(frame, pr::SEGMENTATION_FREE_METHOD);

        for (auto st:res) {
            if (st.confidence > 0.75 ) {
                std::cout << st.getPlateName() << " " << st.confidence << std::endl;
                cv::Rect region = st.getPlateRect();
                cv::rectangle(frame, cv::Point(region.x, region.y),
                              cv::Point(region.x + region.width, region.y + region.height), cv::Scalar(255, 255, 0), 2);

                plateList.append(st.getPlateName());
            }
        }

        imshow("Video", frame);

        if(plateList.size()>4){
            if(plateList.at(plateList.size()-1)==plateList.at(plateList.size()-2)&&
                    plateList.at(plateList.size()-2)==plateList.at(plateList.size()-3)&&
                    plateList.at(plateList.size()-3)==plateList.at(plateList.size()-4)&&
                    plateList.at(plateList.size()-4)==plateList.at(plateList.size()-5)){

                plate = QString(QString::fromLocal8Bit(plateList[plateList.size()-1].c_str()));

                fileName = QString(QString::fromLocal8Bit(currentPath.c_str())) +"carPic/"+ current_date +".jpg";
                String s = string((const char *)fileName.toLocal8Bit());
                imwrite(s, frame);

                break;
            }
        }
        if (waitKey(30) >= 0) break;
    }

    // Release the camera or video cap
    cap.release();
    cvDestroyWindow("Video");

    plateWithPic.append(plate);
    plateWithPic.append(fileName);

    return plateWithPic;
}


QList<QString> PlateRecognize::upPhotoRecognize(QString path){
    QDateTime current_date_time = QDateTime::currentDateTime();
    QString current_date = current_date_time.toString("yyyy.MM.dd.hh.mm.ss");
    path = path.right(path.length()-7);
    String s = string((const char *)path.toLocal8Bit());
    QList<QString> plateWithPic = {};
    QString plate = "";
    QList<String> plateList;
    QString fileName = "";

    pr::PipelinePR prc(currentPath+"model/cascade.xml",
                       currentPath+"model/HorizonalFinemapping.prototxt", currentPath+"model/HorizonalFinemapping.caffemodel",
                       currentPath+"model/Segmentation.prototxt", currentPath+"model/Segmentation.caffemodel",
                       currentPath+"model/CharacterRecognization.prototxt", currentPath+"model/CharacterRecognization.caffemodel",
                       currentPath+"model/SegmentationFree.prototxt", currentPath+"model/SegmentationFree.caffemodel"
                       );


    cv::Mat image = cv::imread(s);

    std::vector<pr::PlateInfo> res = prc.RunPiplineAsImage(image,pr::SEGMENTATION_FREE_METHOD);

    for(auto st:res) {
        if(st.confidence>0.75) {
            std::cout << st.getPlateName() << " " << st.confidence << std::endl;
            cv::Rect region = st.getPlateRect();

            cv::rectangle(image,cv::Point(region.x,region.y),cv::Point(region.x+region.width,region.y+region.height),cv::Scalar(255,255,0),2);
            plateList.append(st.getPlateName());
        }
    }

    //       cv::imshow("image",image);
    //       cv::waitKey(1);
    if(plateList.size()>1){
        plate = "multiple plates";
    }else if(plateList.size() == 1){
        plate = QString(QString::fromLocal8Bit(plateList[0].c_str()));

        fileName = QString(QString::fromLocal8Bit(currentPath.c_str())) +"carPic/"+ current_date +".jpg";
        String s = string((const char *)fileName.toLocal8Bit());
        imwrite(s, image);

    }else{
        plate = "error";
    }
    plateWithPic.append(plate);
    plateWithPic.append(fileName);
    return plateWithPic;
}


QList<QString> PlateRecognize::upVideoRecognize(QString path){
    QDateTime current_date_time = QDateTime::currentDateTime();
    QString current_date = current_date_time.toString("yyyy.MM.dd.hh.mm.ss");
    path = path.right(path.length()-7);
    String s = string((const char *)path.toLocal8Bit());
    QList<QString> plateWithPic = {};
    QString plate = "";
    QList<String> plateList;
    QString fileName = "";

    cv::VideoCapture capture(s);
    cv::Mat frame;

    pr::PipelinePR prc(currentPath+"model/cascade.xml",
                       currentPath+"model/HorizonalFinemapping.prototxt", currentPath+"model/HorizonalFinemapping.caffemodel",
                       currentPath+"model/Segmentation.prototxt", currentPath+"model/Segmentation.caffemodel",
                       currentPath+"model/CharacterRecognization.prototxt", currentPath+"model/CharacterRecognization.caffemodel",
                       currentPath+"model/SegmentationFree.prototxt", currentPath+"model/SegmentationFree.caffemodel"
                       );

    cvNamedWindow("Video", 1);
    while(1) {
        //读取下一帧
        if (!capture.read(frame)) {
            std::cout << "读取视频结束" << std::endl;
            exit(1);
        }
        std::vector<pr::PlateInfo> res = prc.RunPiplineAsImage(frame,pr::SEGMENTATION_FREE_METHOD);

        for(auto st:res) {
            if(st.confidence>0.75) {
                std::cout << st.getPlateName() << " " << st.confidence << std::endl;
                cv::Rect region = st.getPlateRect();
                cv::rectangle(frame,cv::Point(region.x,region.y),cv::Point(region.x+region.width,region.y+region.height),cv::Scalar(255,255,0),2);
                plateList.append(st.getPlateName());
            }
        }

        cv::imshow("Video",frame);
        waitKey(1);

        if(plateList.size()>4){
            if(plateList.at(plateList.size()-1)==plateList.at(plateList.size()-2)&&
                    plateList.at(plateList.size()-2)==plateList.at(plateList.size()-3)&&
                    plateList.at(plateList.size()-3)==plateList.at(plateList.size()-4)&&
                    plateList.at(plateList.size()-4)==plateList.at(plateList.size()-5)){

                plate = QString(QString::fromLocal8Bit(plateList[plateList.size()-1].c_str()));

                fileName = QString(QString::fromLocal8Bit(currentPath.c_str())) +"carPic/"+ current_date +".jpg";
                String s = string((const char *)fileName.toLocal8Bit());
                imwrite(s, frame);

                break;
            }
        }
    }

    cvDestroyWindow("Video");
    plateWithPic.append(plate);
    plateWithPic.append(fileName);
    return plateWithPic;
}
