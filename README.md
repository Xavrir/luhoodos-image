# LuhoodOS Atomic Image

This directory is the Phase 1 bootstrap for the Atomic side of LuhoodOS.

It is already structured like a standalone `uBlue`-style image repository and should be extracted into its own GitHub repository as the next major step.

## Current Goal

The goal of this scaffold is to prove the new delivery model:

- base on `ghcr.io/ublue-os/kinoite-main`
- build a branded LuhoodOS image
- switch or rebase a test system onto that image
- keep the Atomic image flow separate from the legacy Arch ISO flow

## What Is Implemented Here

- `Containerfile` using `kinoite-main`
- minimal `build.sh` that stamps LuhoodOS metadata into the image
- first-pass Plasma shell defaults for new users
- simple `Justfile` for local container builds
- Docker fallback script for local builds on non-uBlue hosts
- example GitHub Actions workflow stubs for image and disk-image builds
- `CHANGELOG.md` scaffold for Keep a Changelog

## What Still Needs Work

- real package and Flatpak decisions
- deeper KDE branding and shell defaults
- Standard and NVIDIA image split
- signing secrets
- disk image builder wiring
- onboarding and Luhood Control integration

## Suggested Next Step

Move this directory into a dedicated GitHub repo and enable Actions there.

Then:

1. set the image owner and image name
2. generate a cosign keypair
3. add the signing secret to GitHub
4. build the first LuhoodOS image
5. rebase a VM onto it

See `REPO_SETUP.md` for the exact handoff steps.

## Local Build Options

On a host with `just` and `podman`:

```bash
just build
```

On a host with Docker only:

```bash
./scripts/build-local-docker.sh
```

To verify an already-built image manually:

```bash
IMAGE_NAME=luhoodos IMAGE_TAG=latest ./scripts/verify-image-metadata.sh
```

## Repo Setup Files

- `REPO_SETUP.md` - extraction and GitHub setup checklist
- `artifacthub-repo.yml` - Artifact Hub publisher metadata
- `LICENSE` - standalone repo license file
- `cosign.pub` - public key for image signature verification after setup

## Layout

```text
luhoodos-image/
├── .github/workflows/
├── scripts/
├── build_files/
├── disk_config/
├── CHANGELOG.md
├── Containerfile
├── Justfile
├── REPO_SETUP.md
└── artifacthub-repo.yml
```
