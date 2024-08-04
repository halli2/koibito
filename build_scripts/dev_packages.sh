#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# TODO:
DEV_PACKAGES=(
    lazygit
)

# JetBrains copr
curl -Lo /etc/yum.repos.d/medzik-jetbrains-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/medzik/jetbrains/repo/fedora-"${RELEASE}"/medzik-jetbrains-fedora-"${RELEASE}".repo
# Devpod
curl -Lo /etc/yum.repos.d/ublue-os-staging-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/ublue-os/staging/repo/fedora-"${RELEASE}"/ublue-os-staging-fedora-"${RELEASE}".repo

IDE_PACKAGES=(
    rustrover
    jetbrains-gateway
    devpod
)

curl -Lo /etc/yum.repos.d/_copr_gmaglione-podman-bootc-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/gmaglione/podman-bootc/repo/fedora-"${RELEASE}"/gmaglione-podman-bootc-fedora-"${RELEASE}".repo
# Images (Podman, Qemu, Bootc dev)
IMG_PACKAGES=(
    # Vm
    qemu
    qemu-img
    virt-manager

    podman-bootc
)

# Rust
RUST=(
    rust
    cargo
    rust-analyzer
    rustfmt
    clippy
    
    # Dev deps
    wayland-devel
    libxkbcommon-devel
    libseat-devel
    libgbm-devel
    libinput-devel
    systemd-devel
)

rpm-ostree install "${IDE_PACKAGES[@]}" "${IMG_PACKAGES[@]}" "${RUST[@]}"
