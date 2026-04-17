#!/usr/bin/env bash
set -euxo pipefail

# ──────────────────────────────────────────────────────────────────────────────
# PHASE 1: Install packages BEFORE overwriting os-release
# (our custom os-release sets VERSION_ID=1.0 which breaks Fedora repo URLs)
# ──────────────────────────────────────────────────────────────────────────────

# Remove broken third-party repos that reference $releasever
rm -f /etc/yum.repos.d/_copr_ublue-os-akmods.repo
rm -f /etc/yum.repos.d/negativo17-fedora-multimedia.repo
rm -f /etc/yum.repos.d/fedora-cisco-openh264.repo

# Install dependencies while os-release still says Fedora 43
rpm-ostree install -y \
  kvantum kvantum-qt6 \
  sassc dialog git \
  plymouth-plugin-script \
  || echo "WARNING: rpm-ostree install had errors; continuing"

# ──────────────────────────────────────────────────────────────────────────────
# PHASE 2: Install WhiteSur theming (git clones, no rpm-ostree needed)
# ──────────────────────────────────────────────────────────────────────────────

# WhiteSur KDE: Global Theme, Kvantum, Aurorae, color schemes
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-kde.git /tmp/WhiteSur-kde
# Install SYSTEM-WIDE for all users (not into $HOME)
export HOME=/tmp/whitesur-home && mkdir -p "$HOME"
bash /tmp/WhiteSur-kde/install.sh -c dark
# Copy from temp home to system-wide locations
cp -r /tmp/whitesur-home/.local/share/aurorae /usr/share/aurorae 2>/dev/null || true
cp -r /tmp/whitesur-home/.local/share/plasma /usr/share/plasma-whitesur-merge 2>/dev/null || true
cp -r /tmp/whitesur-home/.local/share/color-schemes/* /usr/share/color-schemes/ 2>/dev/null || true
# Also try the --global path if the installer supports it
if [ -d /tmp/whitesur-home/.local/share/plasma/look-and-feel ]; then
  cp -r /tmp/whitesur-home/.local/share/plasma/look-and-feel/* /usr/share/plasma/look-and-feel/ 2>/dev/null || true
fi
if [ -d /tmp/whitesur-home/.local/share/plasma/desktoptheme ]; then
  cp -r /tmp/whitesur-home/.local/share/plasma/desktoptheme/* /usr/share/plasma/desktoptheme/ 2>/dev/null || true
fi
# Kvantum themes
if [ -d /tmp/whitesur-home/.config/Kvantum ]; then
  cp -r /tmp/whitesur-home/.config/Kvantum/* /usr/share/Kvantum/ 2>/dev/null || true
fi

# WhiteSur Icons
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-icon-theme.git /tmp/WhiteSur-icon-theme
bash /tmp/WhiteSur-icon-theme/install.sh -a -d /usr/share/icons

# WhiteSur Cursors
git clone --depth=1 https://github.com/vinceliuice/WhiteSur-cursors.git /tmp/WhiteSur-cursors
install -d /usr/share/icons
if [ -d /tmp/WhiteSur-cursors/dist ]; then
  cp -r /tmp/WhiteSur-cursors/dist/* /usr/share/icons/
elif [ -x /tmp/WhiteSur-cursors/install.sh ]; then
  bash /tmp/WhiteSur-cursors/install.sh || true
fi

# WhiteSur SDDM Theme (login screen)
git clone https://github.com/nicefaa6waa9/sddm-whitesur-theme.git /tmp/WhiteSur-sddm \
  || git clone https://github.com/nicofaa99/sddm-whiteSur-theme.git /tmp/WhiteSur-sddm \
  || true
if [ -d /tmp/WhiteSur-sddm ]; then
  install -d /usr/share/sddm/themes/WhiteSur
  cp -r /tmp/WhiteSur-sddm/* /usr/share/sddm/themes/WhiteSur/
fi

# Clean up temporary theme clones
rm -rf /tmp/WhiteSur-kde /tmp/WhiteSur-icon-theme /tmp/WhiteSur-cursors /tmp/WhiteSur-sddm /tmp/whitesur-home

# Debug: list what was actually installed
echo "=== WhiteSur install verification ==="
ls /usr/share/aurorae/themes/ 2>/dev/null || echo "No aurorae themes"
ls /usr/share/plasma/look-and-feel/ | grep -i white || echo "No WhiteSur LAF"
ls /usr/share/plasma/desktoptheme/ | grep -i white || echo "No WhiteSur desktop theme"
ls /usr/share/color-schemes/ | grep -i white || echo "No WhiteSur color schemes"
ls /usr/share/icons/ | grep -i white || echo "No WhiteSur icons"
ls /usr/share/Kvantum/ | grep -i white || echo "No WhiteSur Kvantum"
echo "=== end verification ==="

# ──────────────────────────────────────────────────────────────────────────────
# PHASE 3: Copy rootfs overlay AFTER package installs (includes os-release)
# ──────────────────────────────────────────────────────────────────────────────
cp -a /tmp/build_files/rootfs/. /

# Reset HOME
export HOME=/root

# Activate WhiteSur SDDM login theme
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

# Activate LuhoodOS Plymouth boot splash
if [ -d /usr/share/plymouth/themes/luhoodos ]; then
  plymouth-set-default-theme luhoodos || true
fi

# Copy splash spinner from Fedora theme
install -d /usr/share/plasma/look-and-feel/org.luhoodos.desktop/contents/splash/images
cp /usr/share/plasma/look-and-feel/org.fedoraproject.fedoradark.desktop/contents/splash/images/busywidget.svgz \
   /usr/share/plasma/look-and-feel/org.luhoodos.desktop/contents/splash/images/busywidget.svgz

# ──────────────────────────────────────────────────────────────────────────────
# PHASE 4: LuhoodOS metadata
# ──────────────────────────────────────────────────────────────────────────────
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
