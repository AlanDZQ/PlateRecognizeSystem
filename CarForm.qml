import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.0
import CarController 1.0

Item {
    id:itemForm

    CarController{
        id: carController
    }

    Component{
        id:highlightrec
        Rectangle{
            color: "#DCDCDC"
            radius: 5
            border.color: "#FFFFFF"
        }
    }

    ListModel {
        id: model1
        Component.onCompleted: refresh1()
    }

    function refresh1(){
        model1.clear()
        var list = carController.openCar()
        for(var i = 0; i < list.length; i++){
            model1.append({"plateID": list[i].getPlateID,
                              "type": list[i].getType,
                              "ownerName": list[i].getOwnerName,
                              "ownerID": list[i].getOwnerID,
                              "ownerPhone": list[i].getOwnerPhone,
                              "ownerAddress": list[i].getOwnerAddress
                          })
        }
    }

    Component {
        id: delegate1
        Column {
            id: column1
            property int row: index
            Row {
                spacing: 1
                ItemDelegate {
                    width: view1.headerItem.itemAt(0).width
                    text: plateID
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(1).width
                    text: type
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(2).width
                    text: ownerName
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(3).width
                    text: ownerID
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(4).width
                    text: ownerPhone
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(5).width
                    text: ownerAddress
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
            }

            Rectangle {
                color: "silver"
                width: view1.headerItem.width
                height: 1
            }
        }
    }

    function viewItem(){
    }

    ListView {
        id: view1
        anchors.topMargin: 50
        anchors.fill: parent
        contentWidth: headerItem.width
        flickableDirection: Flickable.HorizontalAndVerticalFlick
        highlightFollowsCurrentItem: true
        highlight: highlightrec
        header: Row {
            z: 2
            spacing: 1
            function itemAt(index) { return repeater1.itemAt(index) }
            Repeater {
                id: repeater1
                model: ["plateID", "type", "ownerName", "ownerID", "ownerPhone", "ownerAddress"]
                Label {
                    text: modelData
                    color: "#ffffffff"
                    font.pixelSize: 20
                    padding: 10
                    width: itemForm.width/6
                    background: Rectangle { color: "#4682B4"}
                    MouseArea {
                        property point clickPoint: "0,0"

                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton
                        onPressed: {
                            clickPoint  = Qt.point(mouse.x, mouse.y)
                            parent.parent.parent.parent.flickableDirection = Flickable.VerticalFlick
                        }
                        onReleased: parent.parent.parent.parent.flickableDirection = Flickable.HorizontalAndVerticalFlick
                        onPositionChanged: {
                            var offset = Qt.point(mouse.x - clickPoint.x, mouse.y - clickPoint.y)
                            setDlgPoint(offset.x, offset.y)
                        }
                        function setDlgPoint(dlgX) {
                            if(width>=50||dlgX>0)
                                parent.width = parent.width + dlgX/100
                        }
                    }
                }
            }
        }
        headerPositioning: ListView.OverlayHeader
        model: model1
        delegate: delegate1
        ScrollIndicator.horizontal: ScrollIndicator { }
        ScrollIndicator.vertical: ScrollIndicator { }
    }

    ToolBar {
        x: 0
        y: 0
        width: parent.width
        height: 50
        Material.background: "#3E6F97"

        ToolButton {
            id: viewButton
            x: parent.width - 60
            width: 60
            height: parent.height
            checkable: false
            autoExclusive: false
            focusPolicy: Qt.StrongFocus
            Image {
                id: viewImage
                x:parent.width/2-15
                y:parent.height/2-15
                width: 30
                height: 30
                source: "view.png"
            }
            onClicked: {
                search();
            }
        }

        TextField {
            id: searchField
            x: parent.width - 200
            height: 50
            placeholderText: "Search"
            clip: true
            Material.accent: "#FFFFFF"
            Material.foreground: "#87CEEB"
            color: "#ffffffff"
            selectByMouse: true
            font.capitalization: Font.MixedCase
            onEditingFinished: {
                search();
            }
        }

        ComboBox {
            id: sortBox
            x: parent.width - 360
            width: 150
            height: 50
            Material.accent: "#87CEEB"
            Material.foreground: "#FFFFFF"
            model: ["plateID", "type", "ownerName", "ownerID", "ownerPhone", "ownerAddress"]
            onCurrentTextChanged: {
                sort(currentText)
            }
        }
    }

    function sort(Text){
        model1.clear()
        var list = carController.sortCar(Text)
        for(var i = 0; i < list.length; i++){
            model1.append({"plateID": list[i].getPlateID,
                              "type": list[i].getType,
                              "ownerName": list[i].getOwnerName,
                              "ownerID": list[i].getOwnerID,
                              "ownerPhone": list[i].getOwnerPhone,
                              "ownerAddress": list[i].getOwnerAddress
                          })
        }
    }

    function search(){
        if (searchField.text === ""){
            refresh1()
        }else{
            model1.clear()
            var list = carController.searchCar(sortBox.currentText, searchField.text)
            for(var i = 0; i < list.length; i++){
                model1.append({"plateID": list[i].getPlateID,
                                  "type": list[i].getType,
                                  "ownerName": list[i].getOwnerName,
                                  "ownerID": list[i].getOwnerID,
                                  "ownerPhone": list[i].getOwnerPhone,
                                  "ownerAddress": list[i].getOwnerAddress
                              })
            }
        }
    }
}
