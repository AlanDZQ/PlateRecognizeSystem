import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import UserController 1.0

Item {
    property string userID: ""
    property string password: ""
    property string name: ""
    property string gender: ""
    property string age: ""
    property string privliege: ""
    property string salary: ""
    property string email: ""
    property string phone: ""
    property string wagecardID: ""
    property string url: ""

    UserController{
        id: userController
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
                text: "Personal Information: " + userID
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
                    if(field1.text===""||field2.text===""||field3.currentText===""||field4.value===0||
                            field5.currentText===""||field6.text===""||field7.text===""||field8.text===""||field9.text===""){
                        warning3.visible=true
                    }else{
                        userController.editUser(userID,field1.text,field2.text,field3.currentText,field4.value,field5.currentText,
                                                field6.text,field7.text,field8.text,field9.text, field10.text)
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
        x: parent.width/2 - 100
        y: 50
        width: 200
        height: 50
        Material.accent: "#87CEEB"
        clip: true
        color: "#87CEEB"
        text: "TextField cannot be null"
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
        visible: false
    }


    Image {
        id: photo
        x: parent.width/6 - parent.width/8
        y: 100
        width: parent.width/4
        height: (parent.height-100)*3/5
        Component.onCompleted: {
            if(url!=="")
                photo.source=url
            else
                photo.source="default.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                photoPopup.open()
            }
        }
    }

    Popup{
        id: photoPopup
        x: parent.width/2 - photoPopup.width/2
        y: parent.height/2 - photoPopup.height/2
        width: 530
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        Text {
            width: parent.width
            height: 40
            anchors.top: parent.top
            text:  "CHOOSE PHOTO"
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
                    if(photoPopup.x + dlgX < 0){
                        photoPopup.x = 0
                    }
                    else if(photoPopup.x + dlgX > photoPopup.parent.width - photoPopup.width){
                        photoPopup.x = photoPopup.parent.width - photoPopup.width
                    }
                    else{
                        photoPopup.x = photoPopup.x + dlgX
                    }
                    if(photoPopup.y + dlgY < 0){
                        photoPopup.y = 0
                    }
                    else if(photoPopup.y + dlgY > photoPopup.parent.height - photoPopup.height){
                        photoPopup.y = photoPopup.parent.height - photoPopup.height
                    }
                    else{
                        photoPopup.y = photoPopup.y + dlgY
                    }
                }
            }
        }
        TextField{
            id: field10
            x:parent.width/2-125
            y:parent.height/2-25
            width: 250
            height: 50
            Material.accent: "#87CEEB"
            placeholderText: "Enter your Pic URL"
        }

        Button {
            x:parent.width/2-125
            y:parent.height/2+25
            width: 250
            height: 50
            text: "choose"
            Material.background: "#87CEEB"
            Material.foreground: "#FFFFFF"
            onClicked:
                photoPopup.close()
        }
    }


    Label {
        x: parent.width/6 - 100
        y: 100 + photo.height
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        color: "#87CEEB"
        text: "Name"
        font.bold: true
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
    }


    TextField {
        id: field2
        x: parent.width/6-100
        y: 100 + photo.height + (parent.height-100)/10
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        selectByMouse: true
        text: name
    }

    Label {
        x: parent.width/2 - 100
        y: 100
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        color: "#87CEEB"
        text: "password"
        font.bold: true
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
    }

    TextField {
        id: field1
        x: parent.width/2-100
        y: 100+(parent.height-100)/10
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        selectByMouse: true
        text: password
    }

    Label {
        x: parent.width/2 - 100
        y: 100+(parent.height-100)/5
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        color: "#87CEEB"
        text: "Gender"
        font.bold: true
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
    }

    ComboBox{
        id: field3
        x: parent.width/2-100
        y: 100+(parent.height-100)*3/10
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        model: ["M", "F"]
        displayText: gender
    }


    Label {
        x: parent.width/2 - 100
        y: 100+(parent.height-100)*2/5
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        color: "#87CEEB"
        text: "Age"
        font.bold: true
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
    }

    SpinBox {
        id: field4
        x: parent.width/2-100
        y: 100+(parent.height-100)/2
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        value: age
        editable: true
//        selectByMouse: true
//        text: age
    }

    Label {
        x: parent.width/2 - 100
        y: 100+(parent.height-100)*3/5
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        color: "#87CEEB"
        text: "Privliege"
        font.bold: true
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
    }

    ComboBox {
        id: field5
        x: parent.width/2-100
        y: 100+(parent.height-100)*7/10
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        model: ["A","C","S"]
        displayText: privliege
    }

    Label {
        x: parent.width*5/6 - 100
        y: 100
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        color: "#87CEEB"
        text: "Salary"
        font.bold: true
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
    }

    TextField {
        id: field6
        x: parent.width*5/6-100
        y: 100 + (parent.height-100)/10
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        selectByMouse: true
        text: salary
    }

    Label {
        x: parent.width*5/6 - 100
        y: 100+(parent.height-100)/5
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        color: "#87CEEB"
        text: "Email"
        font.bold: true
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
    }

    TextField {
        id: field7
        x: parent.width*5/6-100
        y: 100 + (parent.height-100)*3/10
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        selectByMouse: true
        text: email
    }

    Label {
        x: parent.width*5/6 - 100
        y: 100+(parent.height-100)*2/5
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        color: "#87CEEB"
        text: "Phone"
        font.bold: true
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
    }

    TextField {
        id: field8
        x: parent.width*5/6-100
        y: 100 + (parent.height-100)/2
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        selectByMouse: true
        text: phone
    }

    Label {
        x: parent.width*5/6 - 100
        y: 100+(parent.height-100)*3/5
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        color: "#87CEEB"
        text: "WagecardID"
        font.bold: true
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignHCenter
    }

    TextField {
        id: field9
        x: parent.width*5/6-100
        y: 100+(parent.height-100)*7/10
        width: 200
        height: (parent.height-100)/10
        Material.accent: "#87CEEB"
        clip: true
        selectByMouse: true
        text: wagecardID
    }
}
