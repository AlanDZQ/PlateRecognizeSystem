QT += quick\
widgets\
websockets\
texttospeech\
sql\
printsupport

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
QXLSX_PARENTPATH=./         # current QXlsx path is . (. means curret directory)
QXLSX_HEADERPATH=./header/  # current QXlsx header path is ./header/
QXLSX_SOURCEPATH=./source/  # current QXlsx source path is ./source/
include(./QXlsx.pri)

SOURCES += \
        main.cpp\
src/CNNRecognizer.cpp\
src/FastDeskew.cpp\
src/FineMapping.cpp\
src/Pipeline.cpp\
src/PlateDetection.cpp\
src/PlateSegmentation.cpp\
src/Recognizer.cpp\
src/SegmentationFreeRecognizer.cpp\
platerecognize.cpp \
speakitem.cpp\
user.cpp \
car.cpp \
car_status_time.cpp \
finance.cpp \
highway.cpp \
location_highway.cpp \
location.cpp \
carcontroller.cpp \
car_status_timecontroller.cpp \
financecontroller.cpp \
highwaycontroller.cpp \
locationcontroller.cpp \
usercontroller.cpp \
location_highwaycontroller.cpp \
httppost.cpp \
qkuploadfile.cpp \
dbloader.cpp \
    imageprovider.cpp\
toll_time.cpp \
    volume_time.cpp\
path.cpp\
excelconnection.cpp\
        qrcode/bitstream.c \
        qrcode/mask.c \
        qrcode/mmask.c \
        qrcode/mqrspec.c \
        qrcode/qrencode.c \
        qrcode/qrspec.c \
        qrcode/rscode.c \
        qrcode/split.c \
        qrcode/qrinput.c \
    pdfgenerate.cpp \

HEADERS += \
include/CNNRecognizer.h\
include/FastDeskew.h\
include/FineMapping.h\
include/niBlackThreshold.h\
include/Pipeline.h\
include/PlateDetection.h\
include/PlateInfo.h\
include/PlateSegmentation.h\
include/Recognizer.h\
include/SegmentationFreeRecognizer.h\
src/util.h\
platerecognize.h \
speakitem.h\
user.h \
car.h \
car_status_time.h \
finance.h \
highway.h \
location_highway.h \
location.h \
carcontroller.h \
car_status_timecontroller.h \
financecontroller.h \
highwaycontroller.h \
locationcontroller.h \
usercontroller.h \
location_highwaycontroller.h \
httppost.h \
qkuploadfile.h \
dbloader.h \
    imageprovider.h\
toll_time.h \
    volume_time.h\
path.h\
excelconnection.h\
        qrcode/bitstream.h \
        qrcode/mask.h \
        qrcode/mmask.h \
        qrcode/mqrspec.h \
        qrcode/qrencode.h \
        qrcode/qrencode_inner.h \
        qrcode/qrinput.h \
        qrcode/qrspec.h \
        qrcode/rscode.h \
        qrcode/split.h \
        qrcode/config.h \
    pdfgenerate.h \

RESOURCES += qml.qrc\
user.png \
logout.png \
plus.png \
reduce.png \
save.png \
redo.png \
undo.png \
view.png \
default.png \
in.png\
out.png\
chart.png\
list.png\
logo.png\
logo1.png\
port.png\
port1.png\
manual.png\
manual1.png\
camera.png\
camera1.png\
video.png\
video1.png\
carin.png\
carin1.png\
carout.png\
carout1.png\
upvideo.png\
pointer.png\

OTHER_FILES += \
model/CharacterRecognization.caffemodel\
model/CharacterRecognization.prototxt\
model/HorizonalFinemapping.caffemodel\
model/HorizonalFinemapping.prototxt\
model/Segmentation.caffemodel\
model/Segmentation.prototxt\
model/SegmentationFree.caffemodel\
model/SegmentationFree.prototxt\
model/cascade.xml\

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


macx{
 INCLUDEPATH += /usr/local/Cellar/opencv/3.4.1_5/include
 LIBS += -L/usr/local/Cellar/opencv/3.4.1_5/lib -lopencv_stitching -lopencv_superres -lopencv_videostab -lopencv_aruco -lopencv_bgsegm -lopencv_bioinspired -lopencv_ccalib -lopencv_dnn_objdetect -lopencv_dpm -lopencv_face -lopencv_photo -lopencv_fuzzy -lopencv_hfs -lopencv_img_hash -lopencv_line_descriptor -lopencv_optflow -lopencv_reg -lopencv_rgbd -lopencv_saliency -lopencv_stereo -lopencv_structured_light -lopencv_phase_unwrapping -lopencv_surface_matching -lopencv_tracking -lopencv_datasets -lopencv_dnn -lopencv_plot -lopencv_xfeatures2d -lopencv_shape -lopencv_video -lopencv_ml -lopencv_ximgproc -lopencv_calib3d -lopencv_features2d -lopencv_highgui -lopencv_videoio -lopencv_flann -lopencv_xobjdetect -lopencv_imgcodecs -lopencv_objdetect -lopencv_xphoto -lopencv_imgproc -lopencv_core
}
