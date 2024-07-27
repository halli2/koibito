#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

echo "start-hyprland" >> "/usr/etc/greetd/environments"

cp -r usr /

curl -Lo /etc/yum.repos.d/solopasha-hyprland-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/repo/fedora-"${RELEASE}"/solopasha-hyprland-fedora-"${RELEASE}".repo

PACKAGES=(
    hyprland
    hyprpaper
    grimblast
    xdg-desktop-portal-hyprland

    waybar
    dunst

    thunar
    thunar-archive-plugin
    thunar-volman
    xarchiver

    lxqt-policykit
    polkit
)

rpm-ostree install "${PACKAGES[@]}"
