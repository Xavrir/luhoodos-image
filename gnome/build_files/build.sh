#!/usr/bin/env bash
set -euxo pipefail

# Install GNOME prototype packages before any os-release overrides.
rpm-ostree install -y \
  git sassc glib2-devel \
  gnome-tweaks gnome-extensions-app \
  gnome-shell-extension-dash-to-dock \
  gnome-shell-extension-user-theme \
  gnome-shell-extension-blur-my-shell \
  gnome-shell-extension-appindicator \
  || echo "WARNING: rpm-ostree install had errors; continuing"

# Seed LuhoodOS assets early so WhiteSur can use the bundled wallpaper path.
install -D /tmp/build_files/rootfs/usr/share/luhoodos/assets/gemini-luhood-welcome.png \
  /usr/share/luhoodos/assets/gemini-luhood-welcome.png

# WhiteSur GTK + GNOME Shell theme (system-wide)
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-gtk-theme.git /tmp/WhiteSur-gtk
# Use the prebuilt release tarballs for reliability in image builds.
install -d /usr/share/themes
tar -xf /tmp/WhiteSur-gtk/release/WhiteSur-Dark.tar.xz -C /usr/share/themes
tar -xf /tmp/WhiteSur-gtk/release/WhiteSur-Dark-solid.tar.xz -C /usr/share/themes

# WhiteSur icon theme
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-icon-theme.git /tmp/WhiteSur-icon
bash /tmp/WhiteSur-icon/install.sh -a -d /usr/share/icons

# WhiteSur cursors
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-cursors.git /tmp/WhiteSur-cursors
install -d /usr/share/icons
if [ -d /tmp/WhiteSur-cursors/dist ]; then
  cp -r /tmp/WhiteSur-cursors/dist/* /usr/share/icons/
elif [ -x /tmp/WhiteSur-cursors/install.sh ]; then
  bash /tmp/WhiteSur-cursors/install.sh || true
fi

rm -rf /tmp/WhiteSur-gtk /tmp/WhiteSur-icon /tmp/WhiteSur-cursors

# Copy LuhoodOS GNOME overlay files after installs.
cp -a /tmp/build_files/rootfs/. /

# Compile dconf defaults and metadata.
dconf update || true

install -d /usr/share/luhoodos

cat > /usr/share/luhoodos/manifest.json <<'EOF'
{
  "name": "LuhoodOS GNOME Prototype",
  "edition": "gnome-whitesur-prototype",
  "base": "ghcr.io/ublue-os/silverblue-main:latest",
  "desktop": "GNOME",
  "model": "atomic",
  "support": {
    "secureBoot": "post-1.0",
    "images": ["prototype"]
  }
}
EOF

cat > /usr/share/luhoodos/onboarding-defaults.json <<'EOF'
{
  "preinstalled": ["steam", "chromium"],
  "recommended": ["heroic", "lutris", "discord", "obs-studio"],
  "shell": {
    "layout": "gnome-whitesur-maclike",
    "dock": "dash-to-dock",
    "launcher": "overview-and-search"
  }
}
EOF
