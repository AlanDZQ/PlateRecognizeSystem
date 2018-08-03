import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.0
import QtPositioning 5.5
import QtLocation 5.6
import QtQuick.Controls.Material 2.0

import CarController 1.0
import Car_status_timeController 1.0
import LocationController 1.0
import PlateRecognize 1.0

Item {
    property string fileURL: ""

    CarController{
        id: carInfo
    }

    Car_status_timeController{
        id: carIn
    }

    LocationController{
        id: locationInfo
    }

    PlateRecognize{
        id: plateRecognize
    }

    function outputPlate(){
        timeField.text = Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss")
        speakItem.speak("识别成功，车牌号为" + plateField.text)
        var list = carInfo.searchCar("plateID", plateField.text)
        typeField.text = list[0].getType
        ownerNameField.text = list[0].getOwnerName
        ownerIDField.text = list[0].getOwnerID
        ownerPhoneField.text = list[0].getOwnerPhone
        ownerAddressField.text = list[0].getOwnerAddress
    }

    ToolBar {
        z:2
        width: parent.width
        height: 50
        Material.background: "#3E6F97"
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("‹")
                font.bold: true
                font.pointSize: 20
                onClicked: homeStackView.pop()

            }
            Label {
                text: "CAR IN"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                focusPolicy: Qt.StrongFocus
                width: 60
                height: parent.height
                Image {
                    id: viewImage
                    x:parent.width/2-20
                    y:parent.height/2-15
                    width: 40
                    height: 30
                    source: "save.png"
                }
                onClicked: {
                    if(plateField.text !== "" && locationField.currentText !== ""){
                        carIn.addCar_status_time(plateField.text, "I", locationField.currentText, timeField.text, fileURL)
                        overTimer.stop();
                        if (subWindow.visible === true) return;
                        info.text= "add successfully!"
                        subWindow.opacity = 0.0;
                        subWindow.visible = true;
                        downAnimation.start();
                        showAnimation.start();
                        overTimer.start();

                    }else{
                        overTimer.stop();
                        if (subWindow.visible === true) return;
                        info.text= "Fields cannot be null!"
                        subWindow.opacity = 0.0;
                        subWindow.visible = true;
                        downAnimation.start();
                        showAnimation.start();
                        overTimer.start();
                    }
                }
            }
        }
    }

    Rectangle{
        id: leftRect
        width: parent.width/2
        height: parent.height
        color: "#fafafa"
        border.color: "silver"
        border.width: 1

        ToolBar {
            id: toolBar
            y:50
            width: parent.width
            height: 50
            Material.background: "#4682B4"

            ToolButton {
                id: videoButton
                x: 0
                width: parent.width/3
                height: 50
                Image{
                    id: videoImage
                    source: "video.png"
                    x: parent.width/2-15
                    y: parent.height/2-15
                    width: 30
                    height: 30
                }
                onClicked: {
                    var list = plateRecognize.videoRecognize()
                    plateField.text = list[0]
                    outputPlate()
                    carPic.source = "image://imageProvider/" + list[1]
                    fileURL = list[1]
                }
            }

            ToolButton {
                id: upphotoButton
                x: parent.width/3
                width: parent.width/3
                height: 50
                Image{
                    id: upphotoImage
                    source: "camera.png"
                    x: parent.width/2-15
                    y: parent.height/2-15
                    width: 30
                    height: 30
                }
                onClicked: {
                    photoFileDialog.open()
                }
            }

            ToolButton {
                id: upvideoButton
                x: parent.width*2/3
                y: 0
                width: parent.width/3
                height: 50
                Image{
                    id: upvideoImage
                    source: "upvideo.png"
                    x: parent.width/2-15
                    y: parent.height/2-15
                    width: 30
                    height: 30
                }
                onClicked: {
                    videoFileDialog.open()
                }
            }

            FileDialog {
                id: photoFileDialog
                title: "Please choose a file"
                onAccepted: {
                    var list = plateRecognize.upPhotoRecognize(photoFileDialog.fileUrl)
                    plateField.text = list[0]
                    outputPlate()
                    carPic.source= "image://imageProvider/" + list[1]
                    fileURL = list[1]
                }
                onRejected: {
                    console.log("Canceled")
                }
                Component.onCompleted: visible = false
            }

            FileDialog {
                id: videoFileDialog
                title: "Please choose a file"
                onAccepted: {
                    var list = plateRecognize.upVideoRecognize(videoFileDialog.fileUrl)
                    plateField.text = list[0]
                    outputPlate()
                    carPic.source= "image://imageProvider/" + list[1]
                    fileURL = list[1]
                }
                onRejected: {
                    console.log("Canceled")
                }
                Component.onCompleted: visible = false
            }
        }



        Image {
            id: carPic
            x: 0
            y: 100
            width: toolBar.width
            height: toolBar.width*2/3
        }

        Label {
            x: 0
            width: parent.width/3
            height: 50
            color: "#87CEEB"
            text: qsTr("PlateID")
            anchors.top: carPic.bottom
            anchors.topMargin: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: plateField
            x: parent.width/3
            width: parent.width*2/3 - 50
            height: 50
            anchors.top: carPic.bottom
            anchors.topMargin: 50
            Material.accent: "#87CEEB"
            clip: true
            selectByMouse: true
            placeholderText: "PlateID"
        }



        Label {
            x: 0
            width: parent.width/3
            height: 50
            color: "#87CEEB"
            text: qsTr("LocationID")
            anchors.top: plateField.bottom
            anchors.topMargin: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        ComboBox {
            id: locationField
            x: parent.width/3
            width: parent.width*2/3 - 50
            height: 50
            anchors.top: plateField.bottom
            anchors.topMargin: 0
            Material.accent: "#87CEEB"
            model: ListModel {
                id: locationModel
            }
            Component.onCompleted: {
                locationModel.clear()
                var list = locationInfo.openLocation()
                for(var i=0; i<list.length;i++){
                    locationModel.append({text: list[i].getLocationID})
                }
            }
            onCurrentTextChanged: {
                map.center = QtPositioning.coordinate(getXY().latitude, getXY().longitude)
            }
        }

        Plugin {
            id: mapPlugin
            name: "osm"
        }

        Map {
            id: map
            anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: locationField.bottom
            anchors.topMargin: 0
            plugin: mapPlugin
            zoomLevel: 10

            MapItemView {
                model: [1]
                delegate:MapQuickItem {
                    coordinate: QtPositioning.coordinate(getXY().latitude, getXY().longitude)
                    anchorPoint.x: image.width * 0.5
                    anchorPoint.y: image.height
                    sourceItem: Column {
                        Image {
                            id: image
                            width:30
                            height:40
                            source: "pointer.png"
                        }
                        Text { text: getXY().name; font.bold: true }
                    }
                }
            }
        }
    }


    function getXY(){
        var list = locationInfo.searchLocation("locationID", locationField.currentText)
        return {name: list[0].getDescription, latitude: list[0].getLatitude, longitude: list[0].getLongitude}
    }

    Rectangle{
        id: rightRect
        x: parent.width/2
        width: parent.width/2
        height: parent.height
        color: "#fafafa"

        Label {
            id: leftLabel
            x: 0
            y: 0
            width: parent.width/3
            height: 50
            color: "#87CEEB"
            text: qsTr("Type")
            anchors.top: parent.top
            anchors.topMargin: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: typeField
            width: parent.width*2/3 - 50
            height: 50
            anchors.left: leftLabel.right
            anchors.leftMargin: 0
            enabled: false
            anchors.top: parent.top
            anchors.topMargin: 50
            Material.accent: "#87CEEB"
            clip: true
            selectByMouse: true

        }

        Label {
            x: 0
            y: 0
            width: parent.width/3
            height: 50
            color: "#87ceeb"
            text: qsTr("Owner Name")
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 150
        }

        TextField {
            id: ownerNameField
            x: 0
            y: 0
            width: parent.width*2/3 - 50
            height: 50
            anchors.left: leftLabel.right
            anchors.leftMargin: 0
            enabled: false
            anchors.top: parent.top
            selectByMouse: true
            anchors.topMargin: 150
            Material.accent: "#87CEEB"
            clip: true
        }

        Label {
            x: 0
            y: 0
            width: parent.width/3
            height: 50
            color: "#87ceeb"
            text: qsTr("Owner ID")
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 250
        }

        TextField {
            id: ownerIDField
            x: 0
            y: 0
            width: parent.width*2/3 - 50
            height: 50
            anchors.top: parent.top
            anchors.left: leftLabel.right
            anchors.leftMargin: 0
            selectByMouse: true
            anchors.topMargin: 250
            Material.accent: "#87CEEB"
            clip: true
            enabled: false
        }

        Label {
            x: 0
            y: 0
            width: parent.width/3
            height: 50
            color: "#87ceeb"
            text: qsTr("Owner Phone")
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 350
        }

        TextField {
            id: ownerPhoneField
            y: 9
            width: parent.width*2/3 - 50
            height: 50
            anchors.top: parent.top
            anchors.left: leftLabel.right
            anchors.leftMargin: 0
            selectByMouse: true
            anchors.topMargin: 350
            Material.accent: "#87CEEB"
            enabled: false
            clip: true
        }

        Label {
            x: 0
            y: -5
            width: parent.width/3
            height: 50
            color: "#87ceeb"
            text: qsTr("Owner Address")
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 450
        }

        TextField {
            id: ownerAddressField
            y: 5
            width: parent.width*2/3 - 50
            height: 50
            anchors.top: parent.top
            anchors.left: leftLabel.right
            anchors.leftMargin: 0
            selectByMouse: true
            anchors.topMargin: 450
            Material.accent: "#87CEEB"
            clip: true
            enabled: false
        }

        Rectangle{
            width: parent.width
            height: 1
            color: "silver"
            anchors.top: parent.top
            anchors.topMargin: 550
        }

        Label {
            x: 0
            y: -9
            width: parent.width/3
            height: 50
            color: "#87ceeb"
            text: qsTr("Time")
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 570
        }

        TextField {
            id: timeField
            y: 6
            width: parent.width*2/3 - 50
            height: 50
            anchors.top: parent.top
            anchors.left: leftLabel.right
            anchors.leftMargin: 0
            selectByMouse: true
            anchors.topMargin: 570
            Material.accent: "#87CEEB"
            enabled: false
            clip: true
        }

    }
}
