for (const desktop of desktops()) {
    desktop.currentConfigGroup = ["General"];
    desktop.writeConfig("showToolbox", false);
    desktop.wallpaperPlugin = "org.kde.image";
    desktop.currentConfigGroup = ["Wallpaper", "org.kde.image", "General"];
    desktop.writeConfig("Image", "file:///usr/share/luhoodos/wallpapers/luhoodos-shell.svg");
}

const topBar = new Panel;
topBar.location = "top";
topBar.height = 2 * Math.ceil(gridUnit * 1.6 / 2);
topBar.floating = false;

const topLauncher = topBar.addWidget("org.kde.plasma.kickoff");
topLauncher.currentConfigGroup = ["General"];
topLauncher.writeConfig("icon", "start-here-symbolic");

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
dock.height = 2 * Math.ceil(gridUnit * 2.4 / 2);
dock.floating = true;
dock.alignment = "center";
dock.hiding = "dodgewindows";

const geo = screenGeometry(dock.screen);
const dockWidth = Math.min(Math.round(geo.width * 0.42), Math.round(geo.height * 1.9));
dock.minimumLength = dockWidth;
dock.maximumLength = dockWidth;

const tasks = dock.addWidget("org.kde.plasma.icontasks");
tasks.currentConfigGroup = ["General"];
tasks.writeConfig("fill", false);
tasks.writeConfig("launchers", [
    "applications:org.kde.dolphin.desktop",
    "applications:org.chromium.Chromium.desktop",
    "applications:steam.desktop",
    "applications:org.kde.discover.desktop",
    "applications:systemsettings.desktop"
]);
