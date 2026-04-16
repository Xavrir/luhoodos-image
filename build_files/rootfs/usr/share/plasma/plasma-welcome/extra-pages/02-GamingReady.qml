import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.welcome

GenericPage {
    heading: i18nc("@info:window", "Gaming comes first")
    description: i18nc("@info:usagetip", "Steam and Chromium are already part of the base plan. LuhoodOS is being shaped around safe updates, rollback, and hardware-specific images rather than endless manual tweaking.")

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
                    text: i18nc("@info:usagetip", "- Steam preinstalled\n- Chromium default browser\n- Heroic, Lutris, Discord, and OBS recommended during onboarding\n- Atomic rollback-first image model")
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
}
