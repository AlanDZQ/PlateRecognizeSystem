import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import LocationController 1.0
import QtLocation 5.6
import QtPositioning 5.5

Item {
    id: item1
    property string locationID: ""
    property string description: ""
    property string latitude: ""
    property string longitude: ""

    LocationController{
        id: locationController
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
                text: "Location: " + locationID
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
                    if(field1.text===""||field2.text===""||field3.text===""||field4.text===""){
                        warning3.visible=true
                    }else{
                        locationController.editLocation(field1.text,field2.text,field3.text,field4.text)
                        homeStackView.pop()
                        homeStackView.pop()
                        overTimer.stop();
                        if (subWindow.visible === true) return;
                        info.text = "Saved successfully!"
                        subWindow.opacity = 0.0;
                        subWindow.visible = true;
                        downAnimation.start();
                        showAnimation.start();
                        overTimer.start();
                        homeStackView.push("LocationForm.qml")
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


    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        id: map
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: seg.left
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        plugin: mapPlugin
        zoomLevel: 10
        center:QtPositioning.coordinate(latitude, longitude)

        MapItemView {
            model: [1]
            delegate: MapQuickItem {
                coordinate: QtPositioning.coordinate(latitude, longitude)

                anchorPoint.x: image.width * 0.5
                anchorPoint.y: image.height

                sourceItem: Column {
                    Image {
                        id: image
                        width:30
                        height:40
                        source: "pointer.png"
                    }
                    Text { text: description; font.bold: true }
                }
            }
        }
    }

    Rectangle {
        id: seg
        color: "silver"
        x:parent.width/2
        width: 1
        height:item1.height
    }



    Label {
        id: label
        width: 100
        height: 50
        x: parent.width*3/4-125
        text: qsTr("locationID")
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
        text: locationID
        anchors.left: label.right
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 100
        Material.accent: "#87CEEB"
        enabled: false
    }

    Label {
        id: label1
        width: 100
        height: 50
        x: parent.width*3/4-125
        text: qsTr("description")
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
        text: description
        anchors.topMargin: 150
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.left: label1.right
        Material.accent: "#87CEEB"
    }

    Label {
        id: label2
        x: parent.width*3/4-125
        width: 100
        height: 50
        text: qsTr("latitude")
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
        text: latitude
        anchors.topMargin: 200
        anchors.top: parent.top
        Material.accent: "#87CEEB"
        anchors.left: label.right
        anchors.leftMargin: 0
    }

    Label {
        id: label3
        x: parent.width*3/4-125
        width: 100
        height: 50
        text: qsTr("longitude")
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
        text: longitude
        anchors.topMargin: 250
        anchors.top: parent.top
        Material.accent: "#87CEEB"
        anchors.left: label.right
        anchors.leftMargin: 0
    }
}
