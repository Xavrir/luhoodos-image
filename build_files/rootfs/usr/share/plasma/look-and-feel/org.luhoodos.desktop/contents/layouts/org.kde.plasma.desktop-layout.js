for (const desktop of desktops()) {
    desktop.currentConfigGroup = ["General"];
    desktop.writeConfig("showToolbox", false);
    desktop.wallpaperPlugin = "org.kde.image";
    desktop.currentConfigGroup = ["Wallpaper", "org.kde.image", "General"];
    desktop.writeConfig("Image", "file:///usr/share/luhoodos/wallpapers/luhoodos-shell.svg");
}

const topBar = new Panel;
topBar.location = "top";
topBar.height = Math.round(gridUnit * 1.55);
topBar.floating = false;

const launcher = topBar.addWidget("org.kde.plasma.kickerdash");
launcher.currentConfigGroup = ["General"];
launcher.writeConfig("icon", "start-here-luhoodos");

const leftSpacer = topBar.addWidget("org.kde.plasma.panelspacer");
leftSpacer.currentConfigGroup = ["Configuration", "General"];
leftSpacer.writeConfig("expanding", true);

const rightSpacer = topBar.addWidget("org.kde.plasma.panelspacer");
rightSpacer.currentConfigGroup = ["Configuration", "General"];
rightSpacer.writeConfig("expanding", true);

topBar.addWidget("org.kde.plasma.systemtray");
topBar.addWidget("org.kde.plasma.digitalclock");

const dock = new Panel;
dock.location = "bottom";
dock.height = Math.round(gridUnit * 2.5);
dock.floating = true;
dock.alignment = "center";

const geometry = screenGeometry(dock.screen);
const dockWidth = Math.min(Math.round(geometry.width * 0.34), Math.round(geometry.height * 1.7));
dock.minimumLength = dockWidth;
dock.maximumLength = dockWidth;

const tasks = dock.addWidget("org.kde.plasma.icontasks");
tasks.currentConfigGroup = ["General"];
tasks.writeConfig("fill", false);
tasks.writeConfig("groupInline", true);
tasks.writeConfig("iconSpacing", 6);
tasks.writeConfig("launchers", [
    "applications:org.kde.dolphin.desktop",
    "applications:org.chromium.Chromium.desktop",
    "applications:steam.desktop",
    "applications:org.kde.discover.desktop",
    "applications:systemsettings.desktop"
]);
