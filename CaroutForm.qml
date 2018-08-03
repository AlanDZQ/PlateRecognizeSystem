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
import Location_highwayController 1.0
import FinanceController 1.0
import Pdfgenerate 1.0

Item {
    id: item1
    property string fileURL: ""
    property string financeCID: ""

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

    Location_highwayController{
        id: location_highwayController
    }

    FinanceController{
        id: financeController
    }

    Pdfgenerate{
        id :pdfgenerate
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
                text: "CAR OUT"
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
                        carIn.addCar_status_time(plateField.text, "O", locationField.currentText, timeField.text, fileURL)
                        addPopup1.open()
                        var list = location_highwayController.getAllLocFull(plateField.text, locationField.currentText)
                        for (var i =0; i<list.length;i++){
                            mapModel.append({"latitude": list[i].getLatitude,
                                                "longitude": list[i].getLongitude,
                                                "name": list[i].getDescription})
                        }

                        console.log("list[list.length-1].getLatitude"+list[list.length-1].getLatitude+"list[list.length-1].getLongitude"+list[list.length-1].getLongitude+"ID: "+list[list.length-1].getDescription)
                        distance.text = location_highwayController.getLen(plateField.text, locationField.currentText)
                        toll.text = location_highwayController.getCost(plateField.text, locationField.currentText)
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

    Popup {
        id: addPopup1
        x: parent.width/2 - addPopup1.width/2
        y: parent.height/2 - addPopup1.height/2
        width: 600
        height: 600
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        Text {
            width: parent.width
            height: 40
            anchors.top: parent.top
            text:  "PAYMENT"
            color: "#6C6C6C"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            MouseArea {
                property point clickPoint: "0,0"

                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                onPressed: {
                    clickPoint  = Qt.point(mouse.x, mouse.y)
                }
                onPositionChanged: {
                    var offset = Qt.point(mouse.x - clickPoint.x, mouse.y - clickPoint.y)
                    setDlgPoint(offset.x, offset.y)
                }
                function setDlgPoint(dlgX ,dlgY)
                {
                    //设置窗口拖拽不能超过父窗口
                    if(addPopup1.x + dlgX < 0){
                        addPopup1.x = 0
                    }
                    else if(addPopup1.x + dlgX > addPopup1.parent.width - addPopup1.width){
                        addPopup1.x = addPopup1.parent.width - addPopup1.width
                    }
                    else{
                        addPopup1.x = addPopup1.x + dlgX
                    }
                    if(addPopup1.y + dlgY < 0){
                        addPopup1.y = 0
                    }
                    else if(addPopup1.y + dlgY > addPopup1.parent.height - addPopup1.height){
                        addPopup1.y = addPopup1.parent.height - addPopup1.height
                    }
                    else{
                        addPopup1.y = addPopup1.y + dlgY
                    }
                }
            }
        }

        Map {
            id: lilMap
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 200
            anchors.top: parent.top
            anchors.topMargin: 40
            plugin: mapPlugin
            zoomLevel: 10
            center : QtPositioning.coordinate(locationInfo.searchLocation("locationID", locationField.currentText)[0].getLatitude,
                                              locationInfo.searchLocation("locationID", locationField.currentText)[0].getLongitude)

            ListModel{
                id: mapModel
            }

            MapItemView {
                model: mapModel
                delegate: MapQuickItem {
                    coordinate: QtPositioning.coordinate(latitude, longitude)
                    anchorPoint.x: image1.width * 0.5
                    anchorPoint.y: image1.height
                    sourceItem: Column {
                        Image {
                            id: image1
                            width:30
                            height:40
                            source: "pointer.png"
                        }
                        Text { text: name; font.bold: true }
                    }
                }
            }
        }


        Label{
            width: 100
            height: 50
            text: "Distance: "
            anchors.top: parent.top
            anchors.topMargin: 400
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
            color:  "#87CEEB"
        }

        TextField {
            id: distance
            height: 50
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 400
            Material.accent: "#87CEEB"
            enabled: false
        }

        Label{
            width: 100
            height: 50
            text: "toll: "
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.right: parent.right
            anchors.rightMargin: 170
            anchors.top: parent.top
            anchors.topMargin: 400
            color:  "#87CEEB"
        }

        TextField {
            id: toll
            height: 50
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.top: parent.top
            anchors.topMargin: 400
            Material.accent: "#87CEEB"
            enabled: false
        }

        Button {
            text: "pay"
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            Material.background: "#4682B4"
            Material.foreground: "#FFFFFF"
            onClicked: {
                financeCID = carIn.findLastC(plateField.text, timeField.text)
                financeController.addFinance(financeCID, toll.text)
                overTimer.stop();
                if (subWindow.visible === true) return;
                info.text = "Pay successfully!"
                subWindow.opacity = 0.0;
                subWindow.visible = true;
                downAnimation.start();
                showAnimation.start();
                overTimer.start();
                addPopup1.close()
            }
        }

        Button {
            text: "print receipt"
            anchors.left: parent.left
            anchors.leftMargin: 200
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            Material.background: "#4682B4"
            Material.foreground: "#FFFFFF"
            onClicked: {
                receiptFileDialog.open()
            }
        }

        Button {
            text: "cancel"
            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            Material.background: "#4682B4"
            Material.foreground: "#FFFFFF"
            onClicked: {
                addPopup1.close()
            }
        }
    }

    FileDialog {
        id: receiptFileDialog
        title: "Please choose a file"
        onAccepted: {
            financeCID = carIn.findLastC(plateField.text, timeField.text)
            pdfgenerate.deliveryGenerate(financeCID, plateField.text,
                                         typeField.text,
                                         location_highwayController.getAllLocFull(plateField.text, locationField.currentText)[0].getLocationID,
                                         carIn.calCarTimePeriod(plateField.text), locationField.currentText,
                                         timeField.text, distance.text,
                                         toll.text, fileUrl+".pdf")
        }
        onRejected: {
            console.log("Canceled")
        }
        Component.onCompleted: visible = false
        selectExisting: false
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
                delegate: MapQuickItem {
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
