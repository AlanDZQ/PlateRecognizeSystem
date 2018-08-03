import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0
import QtCharts 2.0
import Car_status_timeController 1.0
import LocationController 1.0

Item {

    Car_status_timeController{
        id: car_status_timeController
    }

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
                text: "HIGHWAY CHART"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
        }
    }



    SwipeView {
        id: swipeView
        y : 50
        width: parent.width
        height: parent.height - 50
        currentIndex: 0
//        Item {
//            ChartView {
//                id: chartView1
//                title:"TOLLFEE-TIME"
//                width: parent.width
//                height: parent.height
//                anchors.fill: parent
//                antialiasing: true
//                theme: ChartView.ChartThemeLight
//                animationOptions:ChartView.SeriesAnimations
//                axes: [
//                    DateTimeAxis{
//                        id: xAxis1
//                        format: "yyyy/MM/dd"
//                        titleText: "Time"
//                        min: car_status_timeController.sortCar_status_time("time")[0].getTime
//                        max: car_status_timeController.sortCar_status_time("time")[car_status_timeController.sortCar_status_time("time").length - 1].getTime
//                    },
//                    ValueAxis{
//                        id: yAxis1
//                        min: 0.0
//                        max: 5
//                    }
//                ]

////                BarSeries {
////                    id: barSeries
////                    BarSet {
////                        label: "TotalPrice"
////                        color: "#20B2AA"
////                        values: [""]

////                    }

////                    axisX: BarCategoryAxis {
////                        id : barCategoryAxis
////                        titleText: "TIME"
////                        categories: timeList()
////                    }
////                }


//                Component.onCompleted: {
//                    var locationList = locationController.openLocation()
//                    for (var i = 0; i < locationList.length; i++){
//                        var series = chartView1.createSeries(ChartView.SeriesTypeLine, locationList[i].getLocationID, xAxis1, yAxis1);


//                        console.log(locationList[i].getLocationID)

//                        var list = car_status_timeController.calToll_time(locationList[i].getLocationID)
//                        for(var j = 0; j < list.length; j++){
//                            series.append(list[j].getDate, list[j].getProfit)
//                            console.log(list[j].getDate +", "+list[j].getProfit)
//                        }
//                    }
//                }


//                Rectangle{
//                    id: shadow
//                    color: "#87CEEB"
//                    opacity: 0.6
//                    visible: false
//                }
//                MouseArea{
//                    anchors.fill: parent
//                    hoverEnabled: true
//                    acceptedButtons: Qt.AllButtons

//                    onPressed: {shadow.x = mouseX; shadow.y = mouseY; shadow.visible = true; swipeView.interactive = false}
//                    onMouseXChanged: {shadow.width = mouseX - shadow.x}
//                    onMouseYChanged: {shadow.height = mouseY - shadow.y}
//                    onReleased: {
//                        chartView1.zoomIn(Qt.rect(shadow.x, shadow.y, shadow.width, shadow.height))
//                        shadow.visible = false
//                        swipeView.interactive = true
//                    }
//                    onClicked: {
//                        if (mouse.button === Qt.RightButton) {
//                            contentMenu1.popup()
//                        }
//                    }
//                }
//                Menu {
//                    id: contentMenu1
//                    MenuItem {
//                        text: "Zoom Resize"
//                        onTriggered: {
//                            chartView1.zoomReset()
//                        }
//                    }
//                }
//            }
//        }



        Item {
            ChartView {
                id: chartView1
                title:"TOLL-TIME"
                width: parent.width
                height: parent.height
                anchors.fill: parent
                antialiasing: true
                theme: ChartView.ChartThemeLight
                animationOptions:ChartView.SeriesAnimations
                axes: [
                    DateTimeAxis{
                        id: xAxis1
                        format: "yyyy/MM/dd"
                        titleText: "Time"
                        min: car_status_timeController.sortCar_status_time("time")[0].getTime
                        max: car_status_timeController.sortCar_status_time("time")[car_status_timeController.sortCar_status_time("time").length - 1].getTime
                    },
                    ValueAxis{
                        id: yAxis1
                        min: 0.0
                        max: 5
                    }
                ]

                Component.onCompleted: {
                    var locationList = locationController.openLocation()
                    for (var i = 0; i < locationList.length; i++){
                        var series = chartView1.createSeries(ChartView.SeriesTypeLine, locationList[i].getLocationID, xAxis1, yAxis1);


                        console.log(locationList[i].getLocationID)

                        var list = car_status_timeController.calToll_time(locationList[i].getLocationID)
                        for(var j = 0; j < list.length; j++){
                            series.append(list[j].getDate, list[j].getProfit)
                            console.log(list[j].getDate +", "+list[j].getProfit)
                        }
                    }
                }

                Rectangle{
                    id: shadow1
                    color: "#87CEEB"
                    opacity: 0.6
                    visible: false
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.AllButtons

                    onPressed: {shadow1.x = mouseX; shadow1.y = mouseY; shadow1.visible = true; swipeView.interactive = false}
                    onMouseXChanged: {shadow1.width = mouseX - shadow1.x}
                    onMouseYChanged: {shadow1.height = mouseY - shadow1.y}
                    onReleased: {
                        chartView1.zoomIn(Qt.rect(shadow1.x, shadow1.y, shadow1.width, shadow1.height))
                        shadow1.visible = false
                        swipeView.interactive = true
                    }
                    onClicked: {
                        if (mouse.button === Qt.RightButton) {
                            contentMenu1.popup()
                        }
                    }
                }
                Menu {
                    id: contentMenu1
                    MenuItem {
                        text: "Zoom Resize"
                        onTriggered: {
                            chartView1.zoomReset()
                        }
                    }
                }
            }
        }

        Item {
            ChartView {
                id: chartView2
                title:"FLOW-TIME"
                width: parent.width
                height: parent.height
                anchors.fill: parent
                antialiasing: true
                theme: ChartView.ChartThemeLight
                animationOptions:ChartView.SeriesAnimations
                axes: [
                    DateTimeAxis{
                        id: xAxis
                        format: "yyyy/MM/dd"
                        titleText: "Time"
                        min: car_status_timeController.sortCar_status_time("time")[0].getTime
                        max: car_status_timeController.sortCar_status_time("time")[car_status_timeController.sortCar_status_time("time").length - 1].getTime
                    },
                    ValueAxis{
                        id: yAxis
                        min: 0.0
                        max: 5
                    }
                ]

                Component.onCompleted: {
                    var locationList = locationController.openLocation()
                    for (var i = 0; i < locationList.length; i++){
                        var series = chartView2.createSeries(ChartView.SeriesTypeLine, locationList[i].getLocationID, xAxis, yAxis);


                        console.log(locationList[i].getLocationID)

                        var list = car_status_timeController.calVolume_time(locationList[i].getLocationID)
                        for(var j = 0; j < list.length; j++){
                            series.append(list[j].getDate, list[j].getFlow)
                            console.log(list[j].getDate +", "+list[j].getFlow)
                        }
                    }
                }

                Rectangle{
                    id: shadow2
                    color: "#87CEEB"
                    opacity: 0.6
                    visible: false
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.AllButtons

                    onPressed: {shadow2.x = mouseX; shadow2.y = mouseY; shadow2.visible = true; swipeView.interactive = false}
                    onMouseXChanged: {shadow2.width = mouseX - shadow2.x}
                    onMouseYChanged: {shadow2.height = mouseY - shadow2.y}
                    onReleased: {
                        chartView2.zoomIn(Qt.rect(shadow2.x, shadow2.y, shadow2.width, shadow2.height))
                        shadow2.visible = false
                        swipeView.interactive = true
                    }
                    onClicked: {
                        if (mouse.button === Qt.RightButton) {
                            contentMenu2.popup()
                        }
                    }
                }
                Menu {
                    id: contentMenu2
                    MenuItem {
                        text: "Zoom Resize"
                        onTriggered: {
                            chartView2.zoomReset()
                        }
                    }
                }
            }
        }
    }

    PageIndicator {
          id: indicator
          count: swipeView.count
          currentIndex: swipeView.currentIndex

          anchors.bottom: swipeView.bottom
          anchors.horizontalCenter: parent.horizontalCenter
      }
}
