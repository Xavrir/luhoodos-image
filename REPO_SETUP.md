# LuhoodOS Atomic Repo Setup

## Purpose

This document is the handoff checklist for turning `luhoodos-image/` into its own working GitHub repository.

## 1. Create the Repository

- create a new GitHub repository for the Atomic image
- copy or move the contents of `luhoodos-image/` into the repository root
- make sure `.github/workflows/` lives at the new repo root so Actions will run

Suggested name:

- `luhoodos-image`

## 2. Enable GitHub Actions

- open the `Actions` tab
- enable workflows for the repository

## 3. Set the Final Image Path

Update these files with the real image owner and path:

- `disk_config/iso.toml`
- `.github/workflows/build.yml`
- `.github/workflows/build-disk.yml`
- `Justfile` if the image name changes

Replace the placeholder in `disk_config/iso.toml`:

```text
ghcr.io/REPLACE_ME/luhoodos:latest
```

with the final path, for example:

```text
ghcr.io/Xavrir/luhoodos:latest
```

## 4. Set Up Signing

Install `cosign`, then generate an unencrypted keypair:

```bash
COSIGN_PASSWORD="" cosign generate-key-pair
```

Do not commit `cosign.key`.

Add the private key contents to the GitHub Actions secret:

- `SIGNING_SECRET`

Commit the public key file as `cosign.pub` so users can verify signatures later.

The image build workflow is already wired to sign automatically when `SIGNING_SECRET` exists.

## 5. First Build

- trigger `Build LuhoodOS Image`
- verify the image is published to GHCR
- confirm the smoke-test step passes

## 6. First Disk Images

- update `disk_config/iso.toml` with the final image path first
- trigger `Build LuhoodOS Disk Images`
- verify both `qcow2` and `anaconda-iso` artifacts are produced

## 7. First Rebase Test

- start from a Fedora Kinoite or compatible Atomic VM
- switch or rebase onto the LuhoodOS image
- verify `/usr/share/luhoodos/manifest.json` exists
- verify rollback remains available

## 8. Immediate Post-Extraction Work

- add LuhoodOS KDE shell defaults
- split Standard and NVIDIA variants
- decide the delivery approach for Steam and Chromium
- start implementing Luhood Control
