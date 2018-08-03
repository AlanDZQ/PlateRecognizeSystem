import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import Car_status_timeController 1.0

Item {
    id: item1
    property string cserialID: ""
    property string plateID: ""
    property string status: ""
    property string locationID: ""
    property string time: ""
    property string pic: ""


    Car_status_timeController{
        id: car_Serial
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
                text: "Car Serial: " + cserialID
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
                    if(field1.text===""||field2.text===""||field3.text===""||field4.text===""||
                            field5.text===""||photo.source===""){
                        warning3.visible=true
                    }else{
                        car_Serial.editCar_status_time(field1.text,field2.text,field3.text,field4.text,field5.text,photo.source)
                        homeStackView.pop()
                        overTimer.stop();
                        if (subWindow.visible === true) return;
                        info.text = "Saved successfully!"
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


    Label {
        id: warning3
        width: 200
        height: 50
        Material.accent: "#20B2AA"
        clip: true
        color: "#87CEEB"
        text: "TextField cannot be null"
        anchors.right: parent.right
        anchors.rightMargin: 100
        anchors.top: parent.top
        anchors.topMargin: 50
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
        visible: false
    }


    Image {
        id: photo
        width: parent.width/2
        height: parent.width/3
        anchors.top: parent.top
        anchors.topMargin: 100
        Component.onCompleted: {
            if(pic!=="")
                photo.source=pic
            else
                photo.source="default.png"
        }
    }

    Rectangle {
        color: "silver"
        anchors.left: photo.right
        anchors.leftMargin: 0
        width: 1
        height:item1.height
    }



    Label {
        id: label
        x: parent.width*3/4-125
        width: 100
        height: 50
        text: qsTr("cserialID")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        anchors.topMargin: 100
        color: "#87CEEB"
    }

    TextField {
        id: field1
        width: 150
        height: 50
        text: cserialID
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.left: label.right
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 100
        Material.accent: "#87CEEB"
    }

    Label {
        id: label1
        width: 100
        height: 50
        text: qsTr("plateID")
        x: parent.width*3/4-125
        anchors.topMargin: 150
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        verticalAlignment: Text.AlignVCenter
        color: "#87CEEB"
    }

    TextField {
        id: field2
        width: 150
        height: 50
        text: plateID

        anchors.left: label.right
        anchors.leftMargin: 0
        anchors.topMargin: 150
        anchors.rightMargin: 50
        anchors.top: parent.top
        anchors.right: parent.right
        Material.accent: "#87CEEB"
    }

    Label {
        id: label2
        x: parent.width*3/4-125
        width: 100
        height: 50
        text: qsTr("status")
        anchors.topMargin: 200
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        verticalAlignment: Text.AlignVCenter
        color: "#87CEEB"
    }

    TextField {
        id: field3
        width: 150
        height: 50
        text: status

        anchors.left: label.right
        anchors.leftMargin: 0
        anchors.topMargin: 200
        anchors.rightMargin: 50
        anchors.top: parent.top
        anchors.right: parent.right
        Material.accent: "#87CEEB"
    }

    Label {
        id: label3
        x: parent.width*3/4-125
        width: 100
        height: 50
        text: qsTr("locationID")
        anchors.topMargin: 250
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        verticalAlignment: Text.AlignVCenter
        color: "#87CEEB"
    }

    TextField {
        id: field4
        width: 150
        height: 50
        text: locationID

        anchors.left: label.right
        anchors.leftMargin: 0
        anchors.topMargin: 250
        anchors.rightMargin: 50
        anchors.top: parent.top
        anchors.right: parent.right
        Material.accent: "#87CEEB"
    }

    Label {
        id: label4
        x: parent.width*3/4-125
        width: 100
        height: 50
        text: qsTr("time")
        anchors.topMargin: 300
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        verticalAlignment: Text.AlignVCenter
        color: "#87CEEB"
    }

    TextField {
        id: field5
        width: 150
        height: 50
        text: time

        anchors.left: label.right
        anchors.leftMargin: 0
        anchors.topMargin: 300
        anchors.rightMargin: 50
        anchors.top: parent.top
        anchors.right: parent.right
        Material.accent: "#87CEEB"
    }

}
