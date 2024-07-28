#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# All base packages / services / modifications

# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Bleeding edge podman until quadlet build is included
curl -Lo /etc/yum.repos.d/rhcontainerbot-podman-next-fedora-"${RELEASE}".repo https://copr.fedorainfracloud.org/coprs/rhcontainerbot/podman-next/repo/fedora-"${RELEASE}"/rhcontainerbot-podman-next-fedora-"${RELEASE}".repo

# Nerd fonts
curl -Lo /etc/yum.repos.d/_copr_che-nerd-fonts.repo https://copr.fedorainfracloud.org/coprs/che/nerd-fonts/repo/fedora-"${RELEASE}"/che-nerd-fonts-fedora-"${RELEASE}".repo && \

BAZZITE_PACKAGES=(
    # glow # Not in repos?
    # gum # Not in repos?
    # discover-overlay
    # python3-pip
    # libadwaita
    # duperemove
    # sqlite
    # xwininfo
    xrandr
    # compsize
    # ryzenadj
    # input-remapper
    # i2c-tools
    # udica
    # ladspa-caps-plugins
    # ladspa-noise-suppression-for-voice
    # python3-icoextract
    # tailscale
    # webapp-manager
    btop
    # fish
    # lshw
    xdotool
    # wmctrl
    # libcec
    # yad
    # f3
    # pulseaudio-utils
    unrar
    lzip
    # libxcrypt-compat
    # mesa-libGLU
    # vulkan-tools
    # glibc.i686
    # extest.i686
    # xwiimote-ng
    twitter-twemoji-fonts
    google-noto-sans-cjk-fonts
    lato-fonts
    fira-code-fonts
    nerd-fonts
    fastfetch
    # vim
    # cockpit-networkmanager
    # cockpit-podman
    # cockpit-selinux
    # cockpit-system
    # cockpit-navigator
    # cockpit-storaged
    # topgrade
    ydotool
    # yafti
    # lsb_release
)

rpm-ostree install "${BAZZITE_PACKAGES[@]}"

# rpm-ostree install \
#     ublue-update && \
# mkdir -p /usr/etc/xdg/autostart && \
# sed -i '1s/^/[include]\npaths = ["\/etc\/ublue-os\/topgrade.toml"]\n\n/' /usr/share/ublue-update/topgrade-user.toml && \
# sed -i 's/min_battery_percent.*/min_battery_percent = 20.0/' /usr/etc/ublue-update/ublue-update.toml && \
# sed -i 's/max_cpu_load_percent.*/max_cpu_load_percent = 100.0/' /usr/etc/ublue-update/ublue-update.toml && \
# sed -i 's/max_mem_percent.*/max_mem_percent = 90.0/' /usr/etc/ublue-update/ublue-update.toml && \
# sed -i 's/dbus_notify.*/dbus_notify = false/' /usr/etc/ublue-update/ublue-update.toml && \
# curl -Lo /usr/bin/installcab https://raw.githubusercontent.com/KyleGospo/steam-proton-mf-wmv/master/installcab.py && \
# chmod +x /usr/bin/installcab && \
# curl -Lo /usr/bin/install-mf-wmv https://github.com/KyleGospo/steam-proton-mf-wmv/blob/master/install-mf-wmv.sh && \
# chmod +x /usr/bin/install-mf-wmv && \
# curl -Lo /usr/share/thumbnailers/exe-thumbnailer.thumbnailer https://raw.githubusercontent.com/jlu5/icoextract/master/exe-thumbnailer.thumbnailer && \


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
    fish
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

