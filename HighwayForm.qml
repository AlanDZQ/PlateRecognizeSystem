import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.0
import HighwayController 1.0
import LocationController 1.0
Item {
    id:itemForm

    HighwayController{
        id: highwayController
    }

    LocationController{
        id: locationController
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
        var list = highwayController.openHighway()
        for(var i = 0; i < list.length; i++){
            model1.append({"highwayID": list[i].getHighwayID,
                              "description": list[i].getDescription,
                              "startLocationID": list[i].getStartLocationID,
                              "endLocationID": list[i].getEndLocationID
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
                    text: highwayID
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(1).width
                    text: description
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(2).width
                    text: startLocationID
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(3).width
                    text: endLocationID
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
        if(!stackView.busy)
            homeStackView.push("HighwayItem.qml",{
                                   highwayID: model1.get(view1.currentIndex).highwayID,
                                   description: model1.get(view1.currentIndex).description,
                                   startLocationID: model1.get(view1.currentIndex).startLocationID,
                                   endLocationID: model1.get(view1.currentIndex).endLocationID
                               })

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
                model: ["highwayID", "description", "startLocationID", "endLocationID"]
                Label {
                    text: modelData
                    color: "#ffffffff"
                    font.pixelSize: 20
                    padding: 10
                    width: itemForm.width/4
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
            text:  "ADD NEW ITEM"
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


        Label {
            id: addWarning1
            x: parent.width/2 - 125
            y: 50
            width: 250
            height: 50
            Material.accent: "#4682B4"
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignHCenter
            clip: true
            color: "#4682B4"
            text: "TextField cannot be null"
            visible: false
        }


        TextField {
            id: addField1
            x: parent.width/2 - 125
            y: parent.height/2 - 150
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the highwayID"
        }

        TextField {
            id: addField2
            x: parent.width/2 - 125
            y: parent.height/2 - 100
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the description"
        }

//        TextField {
//            id: addField3
//            x: parent.width/2 - 125
//            y: parent.height/2 - 50
//            width: 250
//            height: 50
//            Material.accent: "#4682B4"
//            clip: true
//            selectByMouse: true
//            placeholderText: "Enter the startLocationID"
//        }

//        TextField {
//            id: addField4
//            x: parent.width/2- 125
//            y: parent.height/2
//            width: 250
//            height: 50
//            Material.accent: "#4682B4"
//            clip: true
//            selectByMouse: true
//            placeholderText: "Enter the endLocationID"
//        }


        Label {
            id: locationLable1
            x: parent.width/2 - 125
            y: parent.height/2 -50
            width: 100
            height: 50
            text: qsTr("LocationID")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }

        ComboBox {
            id: addField3
            y: parent.height/2 -50
            width: 150
            height: 50
            anchors.left: locationLable1.right
            anchors.leftMargin: 0
            Material.accent: "#4682B4"
            model: locationList
        }



        Label {
            id: locationLable2
            x: parent.width/2 - 125
            y: parent.height/2
            width: 100
            height: 50
            text: qsTr("LocationID")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }

        ComboBox {
            id: addField4
            y: parent.height/2
            width: 150
            height: 50
            anchors.left: locationLable2.right
            anchors.leftMargin: 0
            Material.accent: "#4682B4"
            model: locationList
        }

        ListModel{
            id: locationList
            Component.onCompleted: {
                locationList.clear()
                var list =locationController.openLocation()
                for(var i = 0; i < list.length; i++){
                    locationList.append({text: list[i].getLocationID})
                }
            }
        }

        Button {
            x: 150
            y: parent.height - 100
            text: "Add Item"
            Material.background: "#4682B4"
            Material.foreground: "#FFFFFF"
            onClicked: {
                if(addField1.text===""||addField2.text===""||addField3.currentText===""||addField4.currentText==="")
                    addWarning1.visible = true
                else{

                    highwayController.addHighway(addField1.text,addField2.text,addField3.currentText,addField4.currentText)

                    addWarning1.visible = false
                    addPopup1.close()
                    refresh1()
                    overTimer.stop();
                    if (subWindow.visible === true) return;
                    info.text = "Add successfully!"
                    subWindow.opacity = 0.0;
                    subWindow.visible = true;
                    downAnimation.start();
                    showAnimation.start();
                    overTimer.start();
                }
            }
        }

        Button {
            x: parent.width - 150
            y: parent.height - 100

            text: "cancel"
            Material.background: "#4682B4"
            Material.foreground: "#FFFFFF"
            onClicked: {
                addPopup1.close()
            }
        }
    }

    Popup {
        id: deletePopup1
        x: parent.width/2 - deletePopup1.width/2
        y: parent.height/2 - deletePopup1.height/2
        width: 530
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        Text {
            width: parent.width
            height: 40
            anchors.top: parent.top
            text:  "DELETE ITEM"
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
                    if(deletePopup1.x + dlgX < 0){
                        deletePopup1.x = 0
                    }
                    else if(deletePopup1.x + dlgX > deletePopup1.parent.width - deletePopup1.width){
                        deletePopup1.x = deletePopup1.parent.width - deletePopup1.width
                    }
                    else{
                        deletePopup1.x = deletePopup1.x + dlgX
                    }
                    if(deletePopup1.y + dlgY < 0){
                        deletePopup1.y = 0
                    }
                    else if(deletePopup1.y + dlgY > deletePopup1.parent.height - deletePopup1.height){
                        deletePopup1.y = deletePopup1.parent.height - deletePopup1.height
                    }
                    else{
                        deletePopup1.y = deletePopup1.y + dlgY
                    }
                }
            }
        }


        Label {
            width: parent.width
            height: 100
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            Material.accent: "#4682B4"
            clip: true
            color: "#4682B4"
            text: "Delete this item?"
        }

        Button {
            x: 103
            y: 204
            text: "Yes"
            Material.background: "#4682B4"
            Material.foreground: "#FFFFFF"
            onClicked: {
                highwayController.delHighway(model1.get(view1.currentIndex).highwayID)
                deletePopup1.close()
                refresh1()
                overTimer.stop();
                if (subWindow.visible === true) return;
                info.text = "Delete successfully!"
                subWindow.opacity = 0.0;
                subWindow.visible = true;
                downAnimation.start();
                showAnimation.start();
                overTimer.start();
            }
        }

        Button {
            x: 341
            y: 204
            text: "cancel"
            Material.background: "#4682B4"
            Material.foreground: "#FFFFFF"
            onClicked: {
                deletePopup1.close()
            }
        }
    }

    ToolBar {
        x: 0
        y: 0
        width: parent.width
        height: 50
        Material.background: "#3E6F97"


        ToolButton {
            id: plusButton
            width: 60
            height: parent.height
            checkable: false
            autoExclusive: false
            focusPolicy: Qt.StrongFocus
            Image {
                id: plusImage
                x:parent.width/2-15
                y:parent.height/2-15
                width: 30
                height: 30
                source: "plus.png"
            }
            onClicked: {
                addPopup1.open()
            }
        }

        ToolButton {
            id: deleteButton
            x: 60
            width: 60
            height: parent.height
            checkable: false
            autoExclusive: false
            focusPolicy: Qt.StrongFocus
            Image {
                id: deleteImage
                x:parent.width/2-15
                y:parent.height/2-15
                width: 30
                height: 30
                source: "reduce.png"
            }
            onClicked:{
                deletePopup1.open()
            }
        }

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
            model: ["highwayID", "description", "startLocationID", "endLocationID"]
            onCurrentTextChanged: {
                sort(currentText)
            }
        }
    }

    function sort(Text){
        model1.clear()
        var list = highwayController.sortHighway(Text)
        for(var i = 0; i < list.length; i++){
            model1.append({"highwayID": list[i].getHighwayID,
                              "description": list[i].getDescription,
                              "startLocationID": list[i].getStartLocationID,
                              "endLocationID": list[i].getEndLocationID
                          })
        }
    }

    function search(){
        if (searchField.text === ""){
            refresh1()
        }else{
            model1.clear()
            var list = highwayController.searchHighway(sortBox.currentText, searchField.text)
            for(var i = 0; i < list.length; i++){
                model1.append({"highwayID": list[i].getHighwayID,
                                  "description": list[i].getDescription,
                                  "startLocationID": list[i].getStartLocationID,
                                  "endLocationID": list[i].getEndLocationID
                              })
            }
        }
    }
}
