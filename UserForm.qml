import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.0
import UserController 1.0
import Excelconnection 1.0

Item {
    id:itemForm

    UserController{
        id: userController
    }

    Component{
        id:highlightrec
        Rectangle{
            color: "#DCDCDC"
            radius: 5
            border.color: "#FFFFFF"
        }
    }

    Excelconnection{
        id: excelconnection
    }

    ListModel {
        id: model1
        Component.onCompleted: refresh1()
    }

    function refresh1(){
        model1.clear()
        var list = userController.openUser()
        for(var i = 0; i < list.length; i++){
            model1.append({"userID": list[i].getUserID,
                           "password": list[i].getPassword,
                           "name": list[i].getName,
                           "gender": list[i].getGender,
                           "age": list[i].getAge.toString(),
                           "privliege": list[i].getPrivilege,
                           "salary": list[i].getSalary.toString(),
                           "email": list[i].getEmail,
                           "phone": list[i].getPhone,
                           "wagecardID": list[i].getWagecardID
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
                    text: userID
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(1).width
                    text: password
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(2).width
                    text: name
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(3).width
                    text: gender
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(4).width
                    text: age
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(5).width
                    text: privliege
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(6).width
                    text: salary
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(7).width
                    text: email
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(8).width
                    text: phone
                    onClicked: {
                        view1.currentIndex = column1.row
                    }
                    onDoubleClicked: {
                        viewItem()
                    }
                }
                ItemDelegate {
                    width: view1.headerItem.itemAt(9).width
                    text: wagecardID
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
            homeStackView.push("UserItem.qml",{
                                   userID: model1.get(view1.currentIndex).userID,
                                   password: model1.get(view1.currentIndex).password,
                                   name:model1.get(view1.currentIndex).name,
                                   gender:model1.get(view1.currentIndex).gender,
                                   age:model1.get(view1.currentIndex).age,
                                   privliege:model1.get(view1.currentIndex).privliege,
                                   salary:model1.get(view1.currentIndex).salary,
                                   email:model1.get(view1.currentIndex).email,
                                   phone:model1.get(view1.currentIndex).phone,
                                   wagecardID:model1.get(view1.currentIndex).wagecardID,
                                   url: userController.searchUser("userID",model1.get(view1.currentIndex).userID)[0].getHeadPicURL
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
                model: ["UserID", "Password", "Name", "Gender", "Age", "Privliege", "Salary", "Email", "Phone", "WagecardID"]
                Label {
                    text: modelData
                    color: "#ffffffff"
                    font.pixelSize: 20
                    padding: 10
                    width: itemForm.width/10
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
            y: 100
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
            x: parent.width/4 - 125
            y: parent.height/2 - 150
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the UserID"
        }

        TextField {
            id: addField2
            x: parent.width/4 - 125
            y: parent.height/2 - 100
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the Password"
        }

        TextField {
            id: addField3
            x: parent.width/4 - 125
            y: parent.height/2 - 50
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the Name"
        }

        TextField {
            id: addField4
            x: parent.width/4 - 125
            y: parent.height/2
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the Gender"
        }

        TextField {
            id: addField5
            x: parent.width/4 - 125
            y: parent.height/2 + 50
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the Age"
        }

        TextField {
            id: addField6
            x: parent.width*3/4 - 125
            y: parent.height/2 - 150
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the Privliege"
        }

        TextField {
            id: addField7
            x: parent.width*3/4 - 125
            y: parent.height/2 - 100
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the Salary"
        }

        TextField {
            id: addField8
            x: parent.width*3/4 - 125
            y: parent.height/2 - 50
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the Email"
        }

        TextField {
            id: addField9
            x: parent.width*3/4 - 125
            y: parent.height/2
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the Phone"
        }

        TextField {
            id: addField10
            x: parent.width*3/4 - 125
            y: parent.height/2 + 50
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the WagecardID"
        }

        TextField {
            id: addField11
            x: parent.width/2 - 125
            y: parent.height/2 + 100
            width: 250
            height: 50
            Material.accent: "#4682B4"
            clip: true
            selectByMouse: true
            placeholderText: "Enter the PictureURL"
        }

        Button {
            x: 100
            y: parent.height - 100
            text: "ok"
            Material.background: "#4682B4"
            Material.foreground: "#FFFFFF"
            onClicked: {
                if(addField1.text === ""||addField2.text===""||addField3.text===""||addField4.text===""||addField5.text===""||addField6.text===""
                        ||addField7.text===""||addField8.text===""||addField9.text===""||addField10.text==="")
                    addWarning1.visible = true
                else{
                    userController.addUser(addField1.text, addField2.text, addField3.text, addField4.text, addField5.text,
                                           addField6.text, addField7.text, addField8.text, addField9.text, addField10.text, addField11.text)
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
            x: parent.width - 225
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
                userController.delUser(model1.get(view1.currentIndex).userID)
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

    Popup{
        id:previewPopup
        x: parent.width/2 - previewPopup.width/2
        y: parent.height/2 - previewPopup.height/2
        width: 600
        height: 600
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        Text {
            width: parent.width
            height: 40
            anchors.top: parent.top
            text:  "PREVIEW"
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
                    if(previewPopup.x + dlgX < 0){
                        previewPopup.x = 0
                    }
                    else if(previewPopup.x + dlgX > previewPopup.parent.width - previewPopup.width){
                        previewPopup.x = previewPopup.parent.width - previewPopup.width
                    }
                    else{
                        previewPopup.x = previewPopup.x + dlgX
                    }
                    if(previewPopup.y + dlgY < 0){
                        previewPopup.y = 0
                    }
                    else if(previewPopup.y + dlgY > previewPopup.parent.height - previewPopup.height){
                        previewPopup.y = previewPopup.parent.height - previewPopup.height
                    }
                    else{
                        previewPopup.y = previewPopup.y + dlgY
                    }
                }
            }
        }

        ListModel {
            id: premodel
        }

        Component {
            id: predelegate
            Column {
                id: column1
                property int row: index
                Row {
                    spacing: 1
                    ItemDelegate {
                        width: preview.headerItem.itemAt(0).width
                        text: userID
                    }
                    ItemDelegate {
                        width: preview.headerItem.itemAt(1).width
                        text: password
                    }
                    ItemDelegate {
                        width: preview.headerItem.itemAt(2).width
                        text: name
                    }
                    ItemDelegate {
                        width: preview.headerItem.itemAt(3).width
                        text: gender
                    }
                    ItemDelegate {
                        width: preview.headerItem.itemAt(4).width
                        text: age
                    }
                    ItemDelegate {
                        width: preview.headerItem.itemAt(5).width
                        text: privliege
                    }
                    ItemDelegate {
                        width: preview.headerItem.itemAt(6).width
                        text: salary
                    }
                    ItemDelegate {
                        width: preview.headerItem.itemAt(7).width
                        text: email
                    }
                    ItemDelegate {
                        width: preview.headerItem.itemAt(8).width
                        text: phone
                    }
                    ItemDelegate {
                        width: preview.headerItem.itemAt(9).width
                        text: wagecardID
                    }
                }

                Rectangle {
                    color: "silver"
                    width: preview.headerItem.width
                    height: 1
                }
            }
        }

        ListView {
            id: preview
            anchors.topMargin: 50
            anchors.fill: parent
            contentWidth: headerItem.width
            flickableDirection: Flickable.HorizontalAndVerticalFlick
            highlightFollowsCurrentItem: true
            header: Row {
                z: 2
                spacing: 1
                function itemAt(index) { return prerepeater.itemAt(index) }
                Repeater {
                    id: prerepeater
                    model: ["UserID", "Password", "Name", "Gender", "Age", "Privliege", "Salary", "Email", "Phone", "WagecardID"]
                    Label {
                        text: modelData
                        color: "#ffffffff"
                        font.pixelSize: 20
                        padding: 10
                        width: previewPopup.width/11
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
            model: premodel
            delegate: predelegate
            ScrollIndicator.horizontal: ScrollIndicator { }
            ScrollIndicator.vertical: ScrollIndicator { }
        }


        Button {
            x:100
            y: parent.height - 100
            text: "ReplaceDB"
            Material.background: "#4682B4"
            Material.foreground: "#FFFFFF"
            onClicked: {
                excelconnection.saveUserinfo(fileDialogIn.fileUrl)
                previewPopup.close()
                refresh1()
            }
        }


        Button {
            x: parent.width - 150
            y: parent.height - 100

            text: "cancel"
            Material.background: "#4682B4"
            Material.foreground: "#FFFFFF"
            onClicked: {
                previewPopup.close()
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
            x: 120
            width: 60
            height: parent.height
            checkable: false
            autoExclusive: false
            focusPolicy: Qt.StrongFocus
            Image {
                x:parent.width/2-15
                y:parent.height/2-17
                width: 30
                height: 34
                source: "out.png"
            }
            onClicked: {
                fileDialogOut.open()
            }
        }

        FileDialog {
            id: fileDialogOut
            title: "Please choose a file"
            onAccepted: {
                console.log("You chose: " + fileDialogOut.fileUrl)
                excelconnection.dbtoExcel(8, fileDialogOut.fileUrl)
            }
            onRejected: {
                console.log("Canceled")
            }
            Component.onCompleted: visible = false
            selectExisting: false
        }

        ToolButton {
            x: 180
            width: 60
            height: parent.height
            checkable: false
            autoExclusive: false
            focusPolicy: Qt.StrongFocus
            Image {
                x:parent.width/2-15
                y:parent.height/2-17
                width: 30
                height: 34
                source: "in.png"
            }
            onClicked: {
                fileDialogIn.open()
            }
        }

        FileDialog {
            id: fileDialogIn
            title: "Please choose a file"
            onAccepted: {
                console.log("You chose: " + fileDialogIn.fileUrl)
                previewPopup.open()

                premodel.clear()
                var list = excelconnection.openUserinfo(fileDialogIn.fileUrl)
                for(var i = 0; i < list.length; i++){
                    premodel.append({"userID": list[i].getUserID,
                                   "password": list[i].getPassword,
                                   "name": list[i].getName,
                                   "gender": list[i].getGender,
                                   "age": list[i].getAge.toString(),
                                   "privliege": list[i].getPrivilege,
                                   "salary": list[i].getSalary.toString(),
                                   "email": list[i].getEmail,
                                   "phone": list[i].getPhone,
                                   "wagecardID": list[i].getWagecardID
                                  })
                }

            }
            onRejected: {
                console.log("Canceled")
            }
            Component.onCompleted: visible = false
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
            model: ["UserID", "Password", "Name", "Gender", "Age", "Privliege", "Salary", "Email", "Phone", "WagecardID"]
            onCurrentTextChanged: {
                sort(currentText)
            }
        }
    }

    function sort(text){
        model1.clear()
        var list = userController.sortUser(text)
        for(var i = 0; i < list.length; i++){
            model1.append({"userID": list[i].getUserID,
                           "password": list[i].getPassword,
                           "name": list[i].getName,
                           "gender": list[i].getGender,
                           "age": list[i].getAge.toString(),
                           "privliege": list[i].getPrivilege,
                           "salary": list[i].getSalary.toString(),
                           "email": list[i].getEmail,
                           "phone": list[i].getPhone,
                           "wagecardID": list[i].getWagecardID
                          })
        }
    }

    function search(){
        if (searchField.text === ""){
            refresh1()
        }else{
            model1.clear()
            var list = userController.searchUser(sortBox.currentText, searchField.text)
            for(var i = 0; i < list.length; i++){
                model1.append({"userID": list[i].getUserID,
                                  "password": list[i].getPassword,
                                  "name": list[i].getName,
                                  "gender": list[i].getGender,
                                  "age": list[i].getAge.toString(),
                                  "privliege": list[i].getPrivilege,
                                  "salary": list[i].getSalary.toString(),
                                  "email": list[i].getEmail,
                                  "phone": list[i].getPhone,
                                  "wagecardID": list[i].getWagecardID
                              })
            }
        }
    }
}
