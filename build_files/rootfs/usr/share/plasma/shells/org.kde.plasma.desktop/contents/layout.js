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

topBar.addWidget("org.kde.plasma.kickoff");
topBar.addWidget("org.kde.plasma.panelspacer");
topBar.addWidget("org.kde.plasma.panelspacer");
topBar.addWidget("org.kde.plasma.systemtray");
topBar.addWidget("org.kde.plasma.digitalclock");

const dock = new Panel;
dock.location = "bottom";
dock.height = 2 * Math.ceil(gridUnit * 2.4 / 2);
dock.floating = true;
dock.alignment = "center";
dock.hiding = "dodgewindows";

const kickoff = dock.addWidget("org.kde.plasma.kickoff");
kickoff.currentConfigGroup = ["General"];
kickoff.writeConfig("icon", "start-here-kde");

const tasks = dock.addWidget("org.kde.plasma.icontasks");
tasks.currentConfigGroup = ["General"];
tasks.writeConfig("launchers", [
    "applications:org.kde.dolphin.desktop",
    "applications:org.chromium.Chromium.desktop",
    "applications:steam.desktop",
    "applications:org.kde.discover.desktop",
    "applications:systemsettings.desktop"
]);
