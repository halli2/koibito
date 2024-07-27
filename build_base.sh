#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# All base packages / services / modifications

# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Bleeding edge podman until quadlet build is included
curl -Lo /etc/yum.repos.d/rhcontainerbot-podman-next-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/rhcontainerbot/podman-next/repo/fedora-"${RELEASE}"/rhcontainerbot-podman-next-fedora-"${RELEASE}".repo

COMMON_PACKAGES=(
    podman # Until 5.1 is in repos?
    p7zip
    unrar
    zstd
    fontconfig

    wf-recorder
    syncthing
    wl-clipboard
)
CLI_PACKAGES=(
    alacritty
    zsh
    eza
    fd-find
    zoxide
    git-delta
    ripgrep
    just
    helix
    fastfetch
    # Maybe
    npm
)
MEDIA_PACKAGES=(
    mpv
    imv
    zathura
    zathura-pdf-mupdf
    # Jellyfin-shim-mpv weak dependencies<
    python3-pystray
    python3-tkinter
    # Audio
    easyeffects
    pipewire
    wireplumber
    pamixer
    # Until wpctl is better for routes(ports)
    pulseaudio-utils
)

rpm-ostree install "${COMMON_PACKAGES[@]}" "${CLI_PACKAGES[@]}" "${MEDIA_PACKAGES[@]}"


systemctl enable podman.socket


### Remove ublue stuff that is annoying.
# Dont generate .justfile in home folder, use ujust instead.
rm /etc/profile.d/ublue-os-just.sh

