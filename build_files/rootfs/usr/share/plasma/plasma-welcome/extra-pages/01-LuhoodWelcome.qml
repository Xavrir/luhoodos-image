import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.welcome

GenericPage {
    heading: i18nc("@info:window", "Welcome to LuhoodOS")
    description: i18nc("@info:usagetip", "A calmer gaming desktop with rollback-first updates, a Mac-inspired workflow, and a simpler first run than stock Plasma.")

    topContent: [
        Kirigami.UrlButton {
            Layout.topMargin: Kirigami.Units.largeSpacing
            text: i18nc("@action:button", "Open LuhoodOS project")
            url: "https://github.com/Xavrir/luhoodos-image"
        }
    ]

    ColumnLayout {
        anchors.centerIn: parent
        spacing: Kirigami.Units.largeSpacing
        width: Math.min(parent.width * 0.86, Kirigami.Units.gridUnit * 34)

        Image {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: Math.min(parent.width, Kirigami.Units.gridUnit * 24)
            Layout.preferredHeight: Kirigami.Units.gridUnit * 13
            source: "file:///usr/share/luhoodos/assets/gemini-luhood-welcome.png"
            fillMode: Image.PreserveAspectFit
            asynchronous: true
        }

        QQC2.Label {
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            text: i18nc("@info:usagetip", "LuhoodOS is being shaped around a top menu bar, centered dock, Steam-first defaults, and supportable Atomic images instead of endless manual fixing.")
        }
    }
}
