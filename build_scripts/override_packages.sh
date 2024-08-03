#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

function rpm_override() {
  rpm-ostree override replace \
    --experimental \
    --from repo=updates \
    "$@" || true
}

rpm_override vulkan-loader
rpm_override alsa-lib
rpm_override gnutls
rpm_override glib2
rpm_override nspr
rpm_override nss-softokn nss-softokn-freebl 
rpm_override nss-util
rpm_override atk 
rpm_override at-spi2-atk
rpm_override libaom
rpm_override gstreamer1 gstreamer1-plugins-base
rpm_override libdecor
rpm_override libtirpc
rpm_override libuuid
rpm_override libblkid
rpm_override libmount
rpm_override cups-libs
rpm_override libinput
rpm_override libopenmpt
rpm_override llvm-libs
rpm_override zlib-ng-compat
rpm_override fontconfig
rpm_override pciutils-libs
rpm_override libdrm
rpm_override libX11 libX11-common libX11-xcb

rpm-ostree override remove \
    glibc32 \
    || true
