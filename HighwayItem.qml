import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import LocationController 1.0
import QtLocation 5.6
import QtPositioning 5.5
import HighwayController 1.0

Item {
    id: item1
    property string highwayID: ""
    property string description: ""
    property string startLocationID: ""
    property string endLocationID: ""

    LocationController{
        id: locationController
    }

    HighwayController{
        id: highwayController
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
                text: "Highway : " + highwayID
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
//        center:QtPositioning.coordinate(latitude, longitude)

        ListModel{
            id: mapModel
        }

        MapItemView {
            model: mapModel
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

        Component.onCompleted: {
            var startList = locationController.searchLocation("locationID", startLocationID)
            var endList = locationController.searchLocation("locationID", endLocationID)
            mapModel.append({"latitude": startList[0].getLatitude,
                                "longitude": startList[0].getLongitude,
                                "name": "Start: "+startList[0].getDescription})
            mapModel.append({"latitude": endList[0].getLatitude,
                                "longitude": endList[0].getLongitude,
                                "name": "End: "+endList[0].getDescription})
            map.center=QtPositioning.coordinate(endList[0].getLatitude, endList[0].getLongitude)
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
        text: qsTr("highwayID")
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
        text: highwayID
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
        text: qsTr("startLocationID")
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
        text: startLocationID
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
        text: qsTr("endLocationID")
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
        text: endLocationID
        anchors.topMargin: 250
        anchors.top: parent.top
        Material.accent: "#87CEEB"
        anchors.left: label.right
        anchors.leftMargin: 0
    }
}
