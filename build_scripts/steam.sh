#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# TODO: Find out what is unneeded
SUPPORTING_PACKAGES=(
  # jupiter-sd-mounting-btrfs
  at-spi2-core.i686
  atk.i686
  vulkan-loader.i686
  alsa-lib.i686
  fontconfig.i686
  gtk2.i686
  libICE.i686
  libnsl.i686
  libxcrypt-compat.i686
  libpng12.i686
  libXext.i686
  libXinerama.i686
  libXtst.i686
  libXScrnSaver.i686
  NetworkManager-libnm.i686
  nss.i686
  pulseaudio-libs.i686
  libcurl.i686
  systemd-libs.i686
  libva.i686
  libvdpau.i686
  libdbusmenu-gtk3.i686
  libatomic.i686
  pipewire-alsa.i686
  gobject-introspection
  clinfo
)
MESA_PACKAGES=(
  mesa-vulkan-drivers.i686
  mesa-va-drivers-freeworld.i686
  mesa-vdpau-drivers-freeworld.i686
)

# TODO: I dont use these?
EXTRA_PACKAGES=(
  # lutris
  umu-launcher
  # wine-core.x86_64
  # wine-core.i686
  # wine-pulseaudio.x86_64
  # wine-pulseaudio.i686
  # winetricks
  protontricks
  latencyflex-vulkan-layer
  vkBasalt.x86_64
  vkBasalt.i686
  obs-vkcapture.x86_64
  libobs_vkcapture.x86_64
  libobs_glcapture.x86_64
  obs-vkcapture.i686
  libobs_vkcapture.i686
  libobs_glcapture.i686
  mangohud.x86_64
  mangohud.i686
  steam-devices
)

rpm-ostree install "${SUPPORTING_PACKAGES[@]}"

# Why?
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/fedora-updates.repo && \
rpm-ostree install "${MESA_PACKAGES[@]}"

# Disable rpm-fusion except steam then reenable
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree.repo
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo
rpm-ostree install \
    steam
sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo
sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/fedora-updates.repo

rpm-ostree install "${EXTRA_PACKAGES[@]}"

# TODO: Delete?
ln -s wine32 /usr/bin/wine
ln -s wine32-preloader /usr/bin/wine-preloader
ln -s wineserver64 /usr/bin/wineserver
sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nNoDisplay=true@g' /usr/share/applications/winetricks.desktop

# TODO: Delete?
curl -Lo /tmp/latencyflex.tar.xz $(curl https://api.github.com/repos/ishitatsuyuki/LatencyFleX/releases/latest | jq -r '.assets[] | select(.name| test(".*.tar.xz$")).browser_download_url')
mkdir -p /tmp/latencyflex
tar --no-same-owner --no-same-permissions --no-overwrite-dir --strip-components 1 -xvf /tmp/latencyflex.tar.xz -C /tmp/latencyflex
rm -f /tmp/latencyflex.tar.xz
cp -r /tmp/latencyflex/wine/usr/lib/wine/* /usr/lib64/wine/
rm -rf /tmp/latencyflex
curl -Lo /usr/bin/latencyflex https://raw.githubusercontent.com/KyleGospo/LatencyFleX-Installer/main/install.sh
chmod +x /usr/bin/latencyflex
sed -i 's@/usr/lib/wine/@/usr/lib64/wine/@g' /usr/bin/latencyflex
sed -i 's@"dxvk.conf"@"/usr/share/latencyflex/dxvk.conf"@g' /usr/bin/latencyflex
chmod +x /usr/bin/latencyflex
