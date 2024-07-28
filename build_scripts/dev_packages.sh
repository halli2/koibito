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

curl -Lo /etc/yum.repos.d/_copr_gmaglione-podman-bootc-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/gmaglione/podman-bootc/repo/fedora-"${RELEASE}"/gmaglione-podman-bootc-fedora-"${RELEASE}".repo
# Images (Podman, Qemu, Bootc dev)
IMG_PACKAGES=(
    qemu
    qemu-img

    podman-bootc
)

rpm-ostree install "${IDE_PACKAGES[@]}" "${IMG_PACKAGES[@]}"
