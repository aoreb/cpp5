import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import Parser 1.0

Window {
    id: root
    property bool isProcessing: false
    property real circleX1
    property real circleY1
    property real circleX2
    property real circleY2
    property real gotoCircleX1
    property real gotoCircleY1
    property real gotoCircleX2
    property real gotoCircleY2
    property bool coordsSetting: false
    property var pointsM1: []
    property var pointsM2: []
    property bool animatedStop1: false
    property bool animatedStop2: false
    property int stepSize: 20
    visible: true
    width: 1280
    height: 740
    color: "#17202b"
    title: qsTr("Манипуляторы")

    Rectangle {
        color: "#17202b"
        anchors.fill: parent

            Rectangle {
                id: controlMenu
                color: "#0e1620"
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                width: 480

                FieldCustom {
                     id: x1Field
                     anchors.top: parent.top
                     anchors.left: textX1.right
                     anchors.leftMargin: 20
                     validator: RegExpValidator{
                         regExp: /^-?(100(\.0{1,5})?|[1-9][0-9]?(\.[0-9]{1,5})?|0(\.[0-9]{1,5})?)$/
                     }
                }
                Text {
                    id: textX1
                    text: "X1"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: x1Field.verticalCenter
                    font.pixelSize: 18
                    color: "#ffffff"
                }

                FieldCustom {
                     id: x2Field
                     anchors.top: parent.top
                     anchors.right: parent.right
                     anchors.rightMargin: 20
                     validator: RegExpValidator{
                         regExp: /^-?(100(\.0{1,5})?|[1-9][0-9]?(\.[0-9]{1,5})?|0(\.[0-9]{1,5})?)$/
                     }
                }
                Text {
                    text: "X2"
                    anchors.right: x2Field.left
                    anchors.rightMargin: 20
                    anchors.verticalCenter: x2Field.verticalCenter
                    font.pixelSize: 18
                    color: "#ffffff"
                }

                FieldCustom {
                     id: y1Field
                     anchors.top: x1Field.top
                     anchors.left: textY1.right
                     anchors.leftMargin: 20
                     validator: RegExpValidator{
                         regExp: /^-?(100(\.0{1,5})?|[1-9][0-9]?(\.[0-9]{1,5})?|0(\.[0-9]{1,5})?)$/
                     }
                }
                Text {
                    id: textY1
                    text: "Y1"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: y1Field.verticalCenter
                    font.pixelSize: 18
                    color: "#ffffff"
                }

                FieldCustom {
                     id: y2Field
                     anchors.top: x2Field.top
                     anchors.right: parent.right
                     anchors.rightMargin: 20
                     validator: RegExpValidator{
                         regExp: /^-?(100(\.0{1,5})?|[1-9][0-9]?(\.[0-9]{1,5})?|0(\.[0-9]{1,5})?)$/
                     }
                }
                Text {
                    text: "Y2"
                    anchors.right: y2Field.left
                    anchors.rightMargin: 20
                    anchors.verticalCenter: y2Field.verticalCenter
                    font.pixelSize: 18
                    color: "#ffffff"
                }

                FieldCustom {
                     id: r1Field
                     anchors.top: y1Field.top
                     anchors.left: textR1.right
                     anchors.leftMargin: 20
                     validator: RegExpValidator{
                         regExp: /^(100(\.0{1,5})?|[1-9][0-9]?(\.[0-9]{1,5})?|0(\.[0-9]{1,5})?)$/
                     }
                }


                Text {
                    id: textR1
                    text: "R1"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: r1Field.verticalCenter
                    font.pixelSize: 18
                    color: "#ffffff"
                }
                FieldCustom {
                     id: r2Field
                     anchors.top: y2Field.top
                     anchors.right: parent.right
                     anchors.rightMargin: 20
                     validator: RegExpValidator{
                         regExp: /^(100(\.0{1,5})?|[1-9][0-9]?(\.[0-9]{1,5})?|0(\.[0-9]{1,5})?)$/
                     }
                }
                Text {
                    id: textR2
                    text: "R2"
                    anchors.right: r2Field.left
                    anchors.rightMargin: 20
                    anchors.verticalCenter: r2Field.verticalCenter
                    font.pixelSize: 18
                    color: "#ffffff"
                }



                Text {
                    id: x1Text
                    anchors.top: r2Field.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                    font.pixelSize: 18
                    text: "X1: "
                    color: "#ffffff"
                }

                Text {
                    id: y1Text
                    anchors.top: x1Text.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                    font.pixelSize: 18
                    text: "Y1: "
                    color: "#ffffff"
                }

                Text {
                    id: x2Text
                    anchors.bottom: x1Text.bottom
                    anchors.left: textR2.left
                    font.pixelSize: 18
                    text: "X2: "
                    color: "#ffffff"
                }

                Text {
                    id: y2Text
                    anchors.left: x2Text.left
                    anchors.bottom: y1Text.bottom
                    font.pixelSize: 18
                    text: "Y2: "
                    color: "#ffffff"
                }
                Text {
                    id: informationText
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                    anchors.top: y1Text.bottom
                    font.pixelSize: 18
                    text: "Поля обратной свзяи:"
                    color: "#ffffff"
                }

                Text {
                    id: x1TextServer
                    anchors.top: informationText.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                    font.pixelSize: 18
                    text: "X1: "
                    color: "#ffffff"
                }



                Text {
                    id: y1TextServer
                    anchors.top: x1TextServer.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.topMargin: 20
                    font.pixelSize: 18
                    text: "Y1: "
                    color: "#ffffff"
                }

                Text {
                    id: x2TextServer
                    anchors.bottom: x1TextServer.bottom
                    anchors.left: textR2.left
                    font.pixelSize: 18
                    text: "X2: "
                    color: "#ffffff"
                }

                Text {
                    id: y2TextServer
                    anchors.left: x2TextServer.left
                    anchors.bottom: y1TextServer.bottom
                    font.pixelSize: 18
                    text: "Y2: "
                    color: "#ffffff"
                }
                Button {
                    id: startButton
                    anchors.top: y2TextServer.bottom
                    anchors.left: r1Field.left
                    anchors.right: r2Field.right
                    anchors.topMargin: 20
                    height: 40
                    background: Rectangle {
                        color: root.isProcessing ? "#232c37" : "#182433"
                        radius: 5
                        Text {
                            font.pixelSize: 18
                            text: "Начать чтение файла"
                            color: root.isProcessing ? "#b9bfc6" : "#ffffff"
                            anchors.centerIn: parent
                        }
                    }
                    hoverEnabled: true

                    MouseArea {
                           anchors.fill: parent
                           cursorShape: Qt.PointingHandCursor
                           enabled: !root.isProcessing
                           onClicked: {
                               if (x1Field.text !== "" && y1Field.text !== "" && r1Field.text !== "" &&
                                   x2Field.text !== "" && y2Field.text !== "" && r2Field.text !== ""){
                                    root.isProcessing = true
                                    animationTimer.start()
                                    parser.writeValue(x1Field.text, y1Field.text, r1Field.text, x2Field.text, y2Field.text, r2Field.text)
                                    root.isProcessing = false
                               }
                           }
                       }

                    signal writeValue(string value, string value, string value, string value, string value, string value)
                }

                Button {
                    id: resetButton
                    anchors.top: startButton.bottom
                    anchors.topMargin: 20
                    anchors.left: r1Field.left
                    anchors.right: r2Field.right
                    height: 40
                    background: Rectangle {
                        anchors.fill: parent
                        color: root.isProcessing ? "#232c37" : "#182433"
                        radius: 5
                        Text {
                            font.pixelSize: 18
                            text: "Сбросить положение манипуляторов"
                            color: root.isProcessing ? "#b9bfc6" : "#ffffff"
                            anchors.centerIn: parent
                        }
                    }
                    hoverEnabled: true

                    MouseArea {
                           enabled: !root.isProcessing
                           anchors.fill: parent
                           cursorShape: Qt.PointingHandCursor
                           onClicked: {
                                    pointsM1 = []
                                    pointsM2 = []
                                    parser.resetBasic()
                                }
                       }
                    signal resetBasic()
                    }
                }

            Connections {
                target: parser

                onSendCoords: {
                    x1Text.text = "X1: " + x1
                    y1Text.text = "Y1: " + y1
                    x2Text.text = "X2: " + x2
                    y2Text.text = "Y2: " + y2
                    circleX1 = parseFloat(x1)
                    circleY1 = parseFloat(y1)
                    circleX2 = parseFloat(x2)
                    circleY2 = parseFloat(y2)
                    pointsM1.push({x: circleX1, y: circleY1})
                    pointsM2.push({x: circleX2, y: circleY2})
                    coordsSetting = true
                    if(pointsM1.length>1){
                       gotoCircleX1 = pointsM1[pointsM1.length-2].x
                       gotoCircleY1 = pointsM1[pointsM1.length-2].y
                    }
                    else {
                       gotoCircleX1 = circleX1
                       gotoCircleY1 = circleY1
                    }
                    if(pointsM2.length>1){
                       gotoCircleX2 = pointsM2[pointsM2.length-2].x
                       gotoCircleY2 = pointsM2[pointsM2.length-2].y
                    }
                    else {
                       gotoCircleX2 = circleX2
                       gotoCircleY2 = circleY2
                    }
                    animatedStop1 = true
                    animatedStop2 = true
                    canvas.requestPaint()


                }
            }

            Connections {
                target: client

                onSendServerCoords: {
                    x1TextServer.text = "X1: " + x1
                    y1TextServer.text = "Y1: " + y1
                    x2TextServer.text = "X2: " + x2
                    y2TextServer.text = "Y2: " + y2
                }
            }
           Rectangle {
               anchors.top: parent.top
               anchors.bottom: parent.bottom
               anchors.left: parent.left
               anchors.right: controlMenu.left
               color: "#17202b"
            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 20
                width: 700
                height: 700
                color: "#dffaef"
                z: 1
            Canvas {
                anchors.left: parent.left
                width: 700
                height: 700
                id: canvas
                z: 2
                onPaint: {
                  const context  = getContext("2d")
                  context.clearRect(0, 0, width, height)
                  context.beginPath()
                  context.strokeStyle = "#074a43"
                  context.lineWidth  = 1
                  context.moveTo(0, height/2)
                  context.lineTo(width, height/2)
                  context.stroke()
                  context.moveTo(width/2, 0)
                  context.lineTo(width/2, height)
                  context.stroke()

                  const step = 33
                  const maxTicks = 10

                    for (var i = 1; i <= maxTicks; i++) {
                        const x = (width / 2) + (i * step)
                        context.moveTo(x, height / 2 - 3)
                        context.lineTo(x, height / 2 + 3)
                        context.stroke()
                        context.font = "12px Arial"
                        context.fillStyle = "#074a43"
                        context.textAlign = "center"
                        context.fillText((i).toFixed(1), x, height / 2 + 20)

                        const negX = (width / 2) - (i * step)
                        context.moveTo(negX, height / 2 - 3)
                        context.lineTo(negX, height / 2 + 3)
                        context.stroke()
                        context.fillText((-i).toFixed(1), negX, height / 2 + 20)
                    }

                    for (var j = 1; j <= maxTicks; j++) {
                        const y = (height / 2) - (j * step)
                        context.moveTo(width / 2 - 3, y)
                        context.lineTo(width / 2 + 3, y)
                        context.stroke()
                        context.fillText((j).toFixed(1), width / 2 - 20, y + 4)

                        const negY = (height / 2) + (j * step)
                        context.moveTo(width / 2 - 3, negY)
                        context.lineTo(width / 2 + 3, negY)
                        context.stroke();
                        context.fillText((-j).toFixed(1), width / 2 - 20, negY + 4)
                    }

                    if (pointsM1.length > 0) {
                        context.beginPath()
                        context.lineJoin = "round"
                        context.moveTo(width/2 + step*pointsM1[0].x, height/2 - step*pointsM1[0].y)

                            for (i = 1; i < pointsM1.length; i++) {
                                context.lineTo(width/2 + step*pointsM1[i-1].x, height/2 - step*pointsM1[i-1].y)
                            }

                        context.strokeStyle = "#209883"
                        context.lineWidth = 3
                        context.stroke()
                            if (pointsM1.length > 1) {
                        context.moveTo(width/2 + step*pointsM1[pointsM1.length-2].x, height/2 - step*pointsM1[pointsM1.length-2].y)
                        context.lineTo(width/2 + step*gotoCircleX1, height/2 - step*gotoCircleY1)
                        context.stroke()
                            }
                    }
                    if (pointsM2.length > 0) {
                        context.beginPath()
                        context.lineJoin = "round"
                        context.moveTo(width/2 + step*pointsM2[0].x, height/2 - step*pointsM2[0].y)

                            for (i = 1; i < pointsM2.length; i++) {
                                context.lineTo(width/2 + step*pointsM2[i-1].x, height/2 - step*pointsM2[i-1].y)
                            }

                        context.strokeStyle = "#cd2c52"
                        context.lineWidth = 3
                        context.stroke()
                            if (pointsM2.length > 1) {
                        context.moveTo(width/2 + step*pointsM2[pointsM2.length-2].x, height/2 - step*pointsM2[pointsM2.length-2].y)
                        context.lineTo(width/2 + step*gotoCircleX2, height/2 - step*gotoCircleY2)
                        context.stroke()
                            }
                        }


                    if (coordsSetting) {
                        context.beginPath();
                        context.arc(width/2 + step*gotoCircleX1, height/2 - step*gotoCircleY1, 10, 0, Math.PI * 2);
                        context.fillStyle = "#209883";
                        context.strokeStyle = "#0f8366";
                        context.lineWidth = 5;
                        context.stroke();
                        context.fill();
                        context.closePath();
                        context.font = "bold 18px Arial"
                        context.fillStyle = "#ffffff"
                        context.textAlign = "center"
                        context.fillText("1", width/2 + step*gotoCircleX1, height/2 - step*gotoCircleY1 + 5)

                        context.beginPath();
                        context.arc(width/2 + step*gotoCircleX2, height/2 - step*gotoCircleY2, 10, 0, Math.PI * 2)
                        context.fillStyle = "#cd2c52"
                        context.strokeStyle = "#8f0234"
                        context.lineWidth = 5
                        context.stroke();
                        context.fill()
                        context.closePath()
                        context.font = "bold 18px Arial"
                        context.fillStyle = "#ffffff"
                        context.textAlign = "center"
                        context.fillText("2", width/2 + step*gotoCircleX2, height/2 - step*gotoCircleY2 + 5)
                     }
                  }

                }
                Timer {
                    id: animationTimer
                    interval: 36
                    repeat: true
                    onTriggered: {
                        if(pointsM1.length > 1) {
                            if(animatedStop1){
                                if (Math.abs(circleX1 - gotoCircleX1) <= Math.abs((circleX1 - pointsM1[pointsM1.length-2].x) / stepSize )
                                        && Math.abs(circleY1 - gotoCircleY1) <= Math.abs((circleY1 - pointsM1[pointsM1.length-2].y) / stepSize)) {
                                    gotoCircleX1 = circleX1;
                                    gotoCircleY1 = circleY1;
                                    animatedStop1 = false;
                                } else {
                                    gotoCircleX1 += (circleX1 - pointsM1[pointsM1.length-2].x) / stepSize ;
                                    gotoCircleY1 += (circleY1 - pointsM1[pointsM1.length-2].y) / stepSize ;
                                }
                             }
                        }
                        if(pointsM2.length > 1) {
                            if(animatedStop2){
                                if (Math.abs(circleX2 - gotoCircleX2) <= (Math.abs(circleX2 - pointsM2[pointsM2.length-2].x) / stepSize)
                                        && Math.abs(circleY2 - gotoCircleY2) <= (Math.abs(circleY2 - pointsM2[pointsM2.length-2].y) / stepSize)) {
                                    gotoCircleX2 = circleX2;
                                    gotoCircleY2 = circleY2;
                                    animatedStop2 = false;
                                } else {
                                    gotoCircleX2 += (circleX2 - pointsM2[pointsM2.length-2].x) / stepSize ;
                                    gotoCircleY2 += (circleY2 - pointsM2[pointsM2.length-2].y) / stepSize ;
                                }
                             }
                        }
                        canvas.requestPaint();
                    }
                }
              }
            }

           }

}
