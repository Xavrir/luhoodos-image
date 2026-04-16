import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.welcome

GenericPage {
    heading: i18nc("@info:window", "Gaming comes first")
    description: i18nc("@info:usagetip", "This welcome flow is intentionally Luhood-only. Steam is already part of the base image, while Heroic, Lutris, Discord, and OBS are meant to be optional next steps instead of cluttering the desktop by default.")

    ColumnLayout {
        anchors.centerIn: parent
        spacing: Kirigami.Units.largeSpacing
        width: Math.min(parent.width * 0.82, Kirigami.Units.gridUnit * 30)

        QQC2.Frame {
            Layout.fillWidth: true

            ColumnLayout {
                anchors.fill: parent
                spacing: Kirigami.Units.smallSpacing

                QQC2.Label {
                    text: i18nc("@title:group", "Current LuhoodOS defaults")
                    font.bold: true
                }

                QQC2.Label {
                    text: i18nc("@info:usagetip", "- Steam preinstalled\n- Chromium default browser\n- Heroic, Lutris, Discord, and OBS recommended later\n- Atomic rollback-first image model\n- Separate Standard and NVIDIA image plan")
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
}
