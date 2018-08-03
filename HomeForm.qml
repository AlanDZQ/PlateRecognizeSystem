import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0
import UserController 1.0

Item {

    UserController{
        id : userController
    }

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


    Component.onCompleted: {
        var list = userController.searchUser("UserID",userID)
        password = list[0].getPassword
        name = list[0].getName
        gender = list[0].getGender
        age =  list[0].getAge.toString()
        privliege =  list[0].getPrivilege
        salary = list[0].getSalary.toString()
        email = list[0].getEmail
        phone = list[0].getPhone
        wagecardID = list[0].getWagecardID
        url = list[0].getHeadPicURL
    }


    StackView {
        id: homeStackView
        x: toolBarLeft.width
        width: parent.width - toolBarLeft.width
        height: parent.height
        initialItem:
            Text {
            id: homeInfo
            color: "#6C6C6C"
            font.family: "Arial"
            font.pixelSize: 20
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            height: parent.height
            width: parent.width
            text:"Click left hand bar to do something"
        }
    }

    ToolBar {
        id: toolBarLeft
        x: 0
        y: 0
        width: 150
        height: parent.height
        Material.background: "#4682B4"
        Material.accent: "#87CEEB"

        Image {
            id: image
            x: parent.width/2 - 45
            y: 20
            width: 90
            height: 30
            source: "logo.png"
        }

        ToolButton {
            y: 100
            width:parent.width
            height:50
            id: inButton
            x: 0
            font.bold: true
            checkable: true
            Image {
                id: inImage
                x:parent.width/2-inImage.width/2
                y:parent.height/2-inImage.height/2
                width: 100
                height: 30
                source: "carin.png"
            }
            autoExclusive: true
            onClicked: {
                inImage.source = "carin1.png"
                outImage.source = "carout.png"

                if(privliege === "C"||privliege === "A"){
                    homeStackView.push("CarinForm.qml")
                }else{
                    overTimer.stop();
                    if (subWindow.visible === true) return;
                    info.text= "No Privliege"
                    subWindow.opacity = 0.0;
                    subWindow.visible = true;
                    downAnimation.start();
                    showAnimation.start();
                    overTimer.start();
                }
            }
        }

        ToolButton {
            y: 150
            width:parent.width
            height:50
            id: outButton
            font.bold: true
            checkable: true
            Image {
                id: outImage
                x:parent.width/2-outImage.width/2
                y:parent.height/2-outImage.height/2
                width: 120
                height: 30
                source: "carout.png"
            }
            autoExclusive: true
            onClicked: {
                outImage.source = "carout1.png"
                inImage.source = "carin.png"

                if(privliege === "C"||privliege === "A"){
                    homeStackView.push("CaroutForm.qml")
                }else{
                    overTimer.stop();
                    if (subWindow.visible === true) return;
                    info.text= "No Privliege"
                    subWindow.opacity = 0.0;
                    subWindow.visible = true;
                    downAnimation.start();
                    showAnimation.start();
                    overTimer.start();
                }
            }
        }

        Rectangle {
            width: 150
            height: 1
            anchors.top: outButton.bottom
            anchors.topMargin: 0
            color: "#3E6F97"
        }

        ToolButton {
            y: 200
            width:parent.width
            height:50
            font.bold: true
            checkable: true
            autoExclusive: true
            text: "Car Serial"
            onClicked: {
                if(privliege === "S"||privliege === "A"){
                    homeStackView.push("Car_SerialForm.qml")
                }else{
                    overTimer.stop();
                    if (subWindow.visible === true) return;
                    info.text= "No Privliege"
                    subWindow.opacity = 0.0;
                    subWindow.visible = true;
                    downAnimation.start();
                    showAnimation.start();
                    overTimer.start();
                }
            }
        }

        ToolButton {
            y: 250
            width:parent.width
            height:50
            font.bold: true
            checkable: true
            autoExclusive: true
            text: "Highway"
            onClicked: {
                if(privliege === "S"||privliege === "A"){
                    homeStackView.push("HighwayForm.qml")
                }else{
                    overTimer.stop();
                    if (subWindow.visible === true) return;
                    info.text= "No Privliege"
                    subWindow.opacity = 0.0;
                    subWindow.visible = true;
                    downAnimation.start();
                    showAnimation.start();
                    overTimer.start();
                }
            }
        }

        ToolButton {
            y: 300
            width:parent.width
            height:50
            font.bold: true
            checkable: true
            autoExclusive: true
            text: "Location"
            onClicked: {
                if(privliege === "S"||privliege === "A"){
                    homeStackView.push("LocationForm.qml")
                }else{
                    overTimer.stop();
                    if (subWindow.visible === true) return;
                    info.text= "No Privliege"
                    subWindow.opacity = 0.0;
                    subWindow.visible = true;
                    downAnimation.start();
                    showAnimation.start();
                    overTimer.start();
                }
            }
        }

        ToolButton {
            y: 350
            width:parent.width
            height:50
            font.bold: true
            checkable: true
            autoExclusive: true
            text: "user"
            onClicked: {
                if(privliege === "S"||privliege === "A"){
                    homeStackView.push("UserForm.qml")
                }else{
                    overTimer.stop();
                    if (subWindow.visible === true) return;
                    info.text= "No Privliege"
                    subWindow.opacity = 0.0;
                    subWindow.visible = true;
                    downAnimation.start();
                    showAnimation.start();
                    overTimer.start();
                }
            }
        }

        ToolButton {
            y: 400
            width:parent.width
            height:50
            font.bold: true
            checkable: true
            autoExclusive: true
            text: "Car"
            onClicked: {
                if(privliege === "S"||privliege === "A"){
                    homeStackView.push("CarForm.qml")
                }else{
                    overTimer.stop();
                    if (subWindow.visible === true) return;
                    info.text= "No Privliege"
                    subWindow.opacity = 0.0;
                    subWindow.visible = true;
                    downAnimation.start();
                    showAnimation.start();
                    overTimer.start();
                }
            }
        }


        ToolButton {
            y: parent.height-100
            width: parent.width
            height:50
            id: personButton
            Image {
                id: userImage
                x:parent.width/2-10
                y:parent.height/2-10
                width: 20
                height: 20
                source: "user.png"
            }
            onClicked: homeStackView.push("UserItem.qml",{
                                              userID: userID,
                                              password: password,
                                              name:name,
                                              gender:gender,
                                              age:age,
                                              privliege:privliege,
                                              salary:salary,
                                              email:email,
                                              phone:phone,
                                              wagecardID:wagecardID,
                                              url:url
                                      })

        }

        ToolButton {
            y: parent.height-50
            width: parent.width
            height:50
            id: logoutButton
            Image {
                id: logoutImage
                x:parent.width/2-10
                y:parent.height/2-10
                width: 20
                height: 20
                source: "logout.png"
            }
            onClicked:stackView.pop()
        }

    }
}
