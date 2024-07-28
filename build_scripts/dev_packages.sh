#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# JetBrains copr
curl -Lo /etc/yum.repos.d/medzik-jetbrains-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/medzik/jetbrains/repo/fedora-"${RELEASE}"/medzik-jetbrains-fedora-"${RELEASE}".repo

# TEMP: Forked devpod
curl -Lo /etc/yum.repos.d/flekz-staging-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/flekz/staging/repo/fedora-"${RELEASE}"/flekz-staging-fedora-"${RELEASE}".repo
# Devpod
#curl -Lo /etc/yum.repos.d/ublue-os-staging-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/ublue-os/staging/repo/fedora-"${RELEASE}"/ublue-os-staging-fedora-"${RELEASE}".repo


IDE_PACKAGES=(
    rustrover
    jetbrains-gateway
    devpod
)

# Images (Podman, Qemu, Bootc dev)
IMG_PACKAGES=(
    qemu
    qemu-img
)

rpm-ostree install "${IDE_PACKAGES[@]}" "${IMG_PACKAGES[@]}"
