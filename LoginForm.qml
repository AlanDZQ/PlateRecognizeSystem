import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import UserController 1.0

Item {

    UserController{
        id:userController
    }

    ToolBar {
        id: loginToolBar
        x: 0
        y: window.height - 50
        width: window.width
        height: 50
        position: ToolBar.Footer
        font.family: "Arial"
        Material.background: "#4682B4"

        ToolButton {
            id: loginButton
            x: 0
            y: 0
            width: window.width
            height: 50
            text: qsTr("Login")
            onClicked: {
                var list = userController.searchUser("UserID", nameField.text)

                if(list[0].getPassword===passwordField.text){
                    stackView.push("HomeForm.qml",{
                                       userID: nameField.text
                                   })
                    overTimer.stop();
                    if (subWindow.visible === true) return;
                    info.text= "Welcome back " + nameField.text
                    subWindow.opacity = 0.0;
                    subWindow.visible = true;
                    downAnimation.start();
                    showAnimation.start();
                    overTimer.start();
                }else{
                    overTimer.stop();
                    if (subWindow.visible === true) return;
                    info.text= "wrong password!"
                    subWindow.opacity = 0.0;
                    subWindow.visible = true;
                    downAnimation.start();
                    showAnimation.start();
                    overTimer.start();
                }
            }
        }
    }

    Image {
        id: image
        x: window.width/2 - 90
        y: window.height/2 - 180
        width: 180
        height: 60
        source: "logo1.png"
    }


    TextField {
        id: nameField
        x: window.width/2 - 125
        y: window.height/2 - 25
        width: 250
        height: 50
        Material.accent: "#87CEEB"
        clip: true
        selectByMouse: true
        placeholderText: "Enter your name"
    }

    TextField {
        id: passwordField
        x: window.width/2 - 125
        y: window.height/2+25
        width: 250
        height: 50
        Material.accent: "#87CEEB"
        clip: true
        placeholderText: "Enter your password"
        echoMode: TextInput.Password
    }

    CheckBox {
        id: checkBox1
        x: parent.width/2-100
        y: parent.height/2+100
        width: 200
        height: 50
        Material.accent: "#87CEEB"
        text: qsTr("Remember me later")
    }
}
