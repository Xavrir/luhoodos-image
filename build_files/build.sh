#!/usr/bin/env bash
set -euxo pipefail

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
- add LuhoodOS KDE shell defaults
- add Standard and NVIDIA image split
- add onboarding and Luhood Control
- validate bootc switch/rebase on a test system
EOF
