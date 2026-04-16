import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Rectangle {
    id: root
    color: "#0b1020"

    property int stage

    Image {
        anchors.fill: parent
        source: "/usr/share/luhoodos/assets/gemini-luhood-welcome.png"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }

    Rectangle {
        anchors.fill: parent
        color: "#0b1020"
        opacity: 0.48
    }

    Column {
        anchors.centerIn: parent
        spacing: Kirigami.Units.largeSpacing

        QQC2.Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "LuhoodOS"
            color: "#f5f7ff"
            font.pixelSize: Kirigami.Units.gridUnit * 2.1
            font.weight: Font.DemiBold
        }

        QQC2.Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Loading your desktop"
            color: "#dbe5ff"
            font.pixelSize: Kirigami.Units.gridUnit * 0.95
            opacity: 0.95
        }

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/busywidget.svgz"
            sourceSize.width: Kirigami.Units.gridUnit * 2
            sourceSize.height: Kirigami.Units.gridUnit * 2
            RotationAnimator on rotation {
                from: 0
                to: 360
                duration: 2000
                loops: Animation.Infinite
                running: Kirigami.Units.longDuration > 1
            }
        }
    }
}
