// LuhoodOS Plasma layout: macOS-style top bar + floating centered dock
for (const desktop of desktops()) {
    desktop.currentConfigGroup = ["General"];
    desktop.writeConfig("showToolbox", false);
    desktop.wallpaperPlugin = "org.kde.image";
    desktop.currentConfigGroup = ["Wallpaper", "org.kde.image", "General"];
    desktop.writeConfig("Image", "file:///usr/share/luhoodos/wallpapers/luhoodos-shell.svg");
}

// --- Top bar: Apple-like menu bar ------------------------------------------
const topBar = new Panel;
topBar.location = "top";
topBar.height = Math.round(gridUnit * 1.6);
topBar.floating = false;
topBar.alignment = "center";
topBar.lengthMode = "fill";

const launcher = topBar.addWidget("org.kde.plasma.kicker");
launcher.currentConfigGroup = ["General"];
launcher.writeConfig("icon", "start-here-luhoodos");
launcher.writeConfig("useExtraRunners", true);

const appMenu = topBar.addWidget("org.kde.plasma.appmenu");
appMenu.currentConfigGroup = ["General"];
appMenu.writeConfig("compactView", false);

const leftSpacer = topBar.addWidget("org.kde.plasma.panelspacer");
leftSpacer.currentConfigGroup = ["Configuration", "General"];
leftSpacer.writeConfig("expanding", true);

topBar.addWidget("org.kde.plasma.systemtray");
topBar.addWidget("org.kde.plasma.digitalclock");

// --- Bottom dock: floating, centered, icons-only tasks ----------------------
const dock = new Panel;
dock.location = "bottom";
dock.height = Math.round(gridUnit * 3);
dock.floating = true;
dock.alignment = "center";
dock.lengthMode = "fitcontent";
dock.hiding = "none";

const tasks = dock.addWidget("org.kde.plasma.icontasks");
tasks.currentConfigGroup = ["General"];
tasks.writeConfig("fill", false);
tasks.writeConfig("showOnlyCurrentScreen", false);
tasks.writeConfig("showOnlyCurrentDesktop", false);
tasks.writeConfig("groupInline", true);
tasks.writeConfig("iconSpacing", 3);
tasks.writeConfig("minimumMargin", 8);
tasks.writeConfig("launchers", [
    "applications:org.kde.dolphin.desktop",
    "applications:org.chromium.Chromium.desktop",
    "applications:steam.desktop",
    "applications:org.kde.discover.desktop",
    "applications:systemsettings.desktop"
]);

dock.addWidget("org.kde.plasma.marginsseparator");
const trash = dock.addWidget("org.kde.plasma.trash");
