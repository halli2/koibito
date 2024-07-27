#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# Update packages that commonly cause build issues
function rpm_override() {
  for pkg in "$@"; do
    rpm-ostree override replace \
      --experimental \
      --from repo=updates \
      "$pkg" || true
  done
}
OVERRIDE_PACKAGES=(
  vulkan-loader
  vulkan-loader
  alsa-lib
  glib2
  nspr
  nss-softokn
  nss-softokn-freebl
  nss-util
  atk
  at-spi2-atk
  libaom
  gstreamer1
  gstreamer1-plugins-base
  libdecor
  libtirpc
  libuuid
  libblkid
  libmount
  cups-libs
  libinput
  libopenmpt
  llvm-libs
  zlib-ng-compat
  fontconfig
  pciutils-libs
  libdrm
)
rpm-ostree override remove glibc32 || true

rpm_override "${OVERRIDE_PACKAGES[@]}"

# Install steam
# sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/fedora-updates.repo
# rpm-ostree install \
#     mesa-vulkan-drivers.i686 \
#     mesa-va-drivers-freeworld.i686 \
#     mesa-vdpau-drivers-freeworld.i686
# sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
# sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree.repo
# sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo
# sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo
# rpm-ostree install steam
# sed -i '0,/enabled=1/s//enabled=0/' /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
# sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree.repo
# sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates.repo
# sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-nonfree-updates-testing.repo
# sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/fedora-updates.repo

# Disable all rpmfusion
for i in /etc/yum.repos.d/rpmfusion-*; do
    sed -i 's@enabled=1@enabled=0@g' "$i"
done

# curl -Lo /etc/yum.repos.d/negativo17-fedora-multimedia.repo https://negativo17.org/repos/fedora-multimedia.repo
curl -Lo /etc/yum.repos.d/negativo17-fedora-steam.repo https://negativo17.org/repos/fedora-steam.repo

rpm-ostree install steam
