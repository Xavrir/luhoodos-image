import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.welcome

GenericPage {
    heading: i18nc("@info:window", "Meet the Luhood desktop")
    description: i18nc("@info:usagetip", "LuhoodOS starts with a top menu bar, a centered dock, and a keyboard-first launcher so the system feels calmer and more deliberate than stock Plasma.")

    topContent: [
        Kirigami.UrlButton {
            Layout.topMargin: Kirigami.Units.largeSpacing
            text: i18nc("@action:button", "View the image project")
            url: "https://github.com/Xavrir/luhoodos-image"
        }
    ]

    ColumnLayout {
        anchors.centerIn: parent
        spacing: Kirigami.Units.largeSpacing
        width: Math.min(parent.width * 0.78, Kirigami.Units.gridUnit * 28)

        Kirigami.Icon {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: Kirigami.Units.gridUnit * 8
            Layout.preferredHeight: Layout.preferredWidth
            source: "file:///usr/share/luhoodos/wallpapers/luhoodos-shell.svg"
        }

        QQC2.Label {
            Layout.fillWidth: true
            text: i18nc("@info:usagetip", "The first shell pass already moves window controls to the left, keeps the dock focused on core apps, and replaces generic Fedora onboarding with LuhoodOS-specific welcome content.")
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
