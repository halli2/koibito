#!/bin/bash
set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# TODO: Make it so it doesn't have to be run after greetd
echo "start-sway" >> "/usr/etc/greetd/environments"


PACKAGES=(
    thunar
    thunar-archive-plugin
    thunar-volman
    xarchiver

    dunst
    grim
    slurp
    grimshot
    kanshi
    sway
    sway-config-fedora
    swaybg
    waybar
    lxpolkit
    wlr-randr
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
)

rpm-ostree install "${PACKAGES[@]}"
