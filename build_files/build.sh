#!/usr/bin/env bash
set -euxo pipefail

cp -a /tmp/build_files/rootfs/. /

# Remove broken third-party repos (base image resolves $releasever as 1.0)
rm -f /etc/yum.repos.d/_copr_ublue-os-akmods.repo
rm -f /etc/yum.repos.d/negativo17-fedora-multimedia.repo
rm -f /etc/yum.repos.d/fedora-cisco-openh264.repo

# Install WhiteSur + macOS feel dependencies. rpm-ostree here may fail on
# base images where the Fedora release metadata cannot resolve $releasever;
# the theming below works without these, so treat them as best-effort.
rpm-ostree install -y \
  kvantum kvantum-qt6 \
  sassc dialog git \
  appmenu-gtk3-module libdbusmenu libdbusmenu-gtk3 \
  plymouth-plugin-script \
  || echo "rpm-ostree install skipped; continuing without optional theming packages"

# Install WhiteSur Global Theme, Kvantum Theme, and Aurorae (dark variant)
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-kde.git /tmp/WhiteSur-kde
bash /tmp/WhiteSur-kde/install.sh -c dark

# Install WhiteSur Icon Theme (all variants, alternative colors)
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-icon-theme.git /tmp/WhiteSur-icon-theme
bash /tmp/WhiteSur-icon-theme/install.sh -a -d /usr/share/icons

# Install WhiteSur Cursors
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-cursors.git /tmp/WhiteSur-cursors
install -d /usr/share/icons
if [ -d /tmp/WhiteSur-cursors/dist ]; then
  cp -r /tmp/WhiteSur-cursors/dist/* /usr/share/icons/
elif [ -x /tmp/WhiteSur-cursors/install.sh ]; then
  bash /tmp/WhiteSur-cursors/install.sh || true
fi

# Install WhiteSur SDDM Theme (login screen)
git clone https://github.com/nicefaa6waa9/sddm-whitesur-theme.git /tmp/WhiteSur-sddm \
  || git clone https://github.com/nicofaa99/sddm-whiteSur-theme.git /tmp/WhiteSur-sddm \
  || true
if [ -d /tmp/WhiteSur-sddm ]; then
  install -d /usr/share/sddm/themes/WhiteSur
  cp -r /tmp/WhiteSur-sddm/* /usr/share/sddm/themes/WhiteSur/
fi

# Clean up temporary theme clones
rm -rf /tmp/WhiteSur-kde /tmp/WhiteSur-icon-theme /tmp/WhiteSur-cursors /tmp/WhiteSur-sddm

# Activate WhiteSur SDDM login theme as system default (only if the theme exists)
if [ -d /usr/share/sddm/themes/WhiteSur ]; then
  install -d /usr/lib/sddm/sddm.conf.d
  cat > /usr/lib/sddm/sddm.conf.d/10-luhoodos.conf <<'EOF'
[Theme]
Current=WhiteSur

[General]
InputMethod=

[Wayland]
EnableHiDPI=true
EOF
fi

# Activate LuhoodOS Plymouth boot splash if assets are present
if [ -d /usr/share/plymouth/themes/luhoodos ]; then
  plymouth-set-default-theme luhoodos || true
fi

install -d /usr/share/plasma/look-and-feel/org.luhoodos.desktop/contents/splash/images
cp /usr/share/plasma/look-and-feel/org.fedoraproject.fedoradark.desktop/contents/splash/images/busywidget.svgz /usr/share/plasma/look-and-feel/org.luhoodos.desktop/contents/splash/images/busywidget.svgz

install -d /usr/share/luhoodos

cat > /usr/share/luhoodos/manifest.json <<'EOF'
{
  "name": "LuhoodOS",
  "edition": "scaffold",
  "base": "ghcr.io/ublue-os/kinoite-main:latest",
  "desktop": "KDE Plasma",
  "model": "atomic",
  "support": {
    "secureBoot": "post-1.0",
    "images": ["standard", "nvidia"]
  }
}
EOF

cat > /usr/share/luhoodos/onboarding-defaults.json <<'EOF'
{
  "preinstalled": ["steam", "chromium"],
  "recommended": ["heroic", "lutris", "discord", "obs-studio"],
  "shell": {
    "layout": "mac-like-top-bar",
    "dock": "bottom",
    "launcher": "spotlight-style"
  }
}
EOF

cat > /usr/share/luhoodos/next-steps.txt <<'EOF'
LuhoodOS image scaffold installed.

Next implementation tasks:
- add Standard and NVIDIA image split
- add onboarding and Luhood Control
- validate bootc switch/rebase on a test system
EOF
