import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Dialogs 1.0
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.0

import PlateRecognize 1.0
import SpeakItem 1.0
import CarController 1.0
import Car_status_timeController 1.0
import FinanceController 1.0
import HighwayController 1.0
import Location_highwayController 1.0
import LocationController 1.0
import UserController 1.0


ApplicationWindow {

    id: window
    visible: true
    width: 900
    height: 800
    title: qsTr("System")

    SpeakItem{
        id: speakItem
    }

    FinanceController{
        id: financeController
    }

    HighwayController{
        id: highwayController
    }

    Location_highwayController{
        id: location_highwayController
    }

    LocationController{
        id: locationController
    }

    UserController{
        id: userController
    }

    StackView {
        id: stackView
        initialItem: "LoginForm.qml"
        anchors.fill: parent
    }

    Timer{
        id: overTimer
        interval: 1000
        repeat: false
        onTriggered: {
            upAnimation.start();
            hideAnimation.start();
        }
    }

    PropertyAnimation{
        id: showAnimation
        target: subWindow
        properties:"opacity"
        from: 0.0
        to: 1.0
        duration: 500
    }

    PropertyAnimation{
        id: hideAnimation
        target: subWindow
        properties:"opacity"
        from: 1.0
        to: 0.0
        duration: 300
        onStopped: {
            subWindow.visible = false;
        }
    }

    PropertyAnimation{
        id: downAnimation
        target: subWindow
        properties:"y"
        duration: 300
    }

    PropertyAnimation{
        id: upAnimation
        target: subWindow
        properties:"y"
        duration: 300
    }

    Window{
        flags: Qt.FramelessWindowHint
        color: "#ffffff"
        id: subWindow
        visible: false
        height: 200
        width: 300
        Text {
            id: info
            color: "#6C6C6C"
            font.family: "Arial"
            font.pixelSize: 20
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            height: parent.height
            width: parent.width
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                overTimer.stop();
            }
            onExited: {
                overTimer.start();
            }
        }
    }
}
