#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# Install Valve's patched Mesa, Pipewire, Bluez, and Xwayland
# Install patched switcheroo control with proper discrete GPU support

MULTILIB_PACKAGES=(
  mesa-filesystem
  mesa-libxatracker
  mesa-libglapi
  mesa-dri-drivers
  mesa-libgbm
  mesa-libEGL
  mesa-vulkan-drivers
  mesa-libGL
  pipewire
  pipewire-alsa
  pipewire-gstreamer
  pipewire-jack-audio-connection-kit
  pipewire-jack-audio-connection-kit-libs
  pipewire-libs
  pipewire-pulseaudio
  pipewire-utils
  pipewire-plugin-libcamera
  bluez
  bluez-obexd
  bluez-cups
  bluez-libs
  xorg-x11-server-Xwayland
)
rpm-ostree override remove \
  mesa-va-drivers-freeworld

rpm-ostree override replace \
  --experimental \
  --from repo=copr:copr.fedorainfracloud.org:kylegospo:bazzite-multilib \
    "${MULTILIB_PACKAGES[@]}"

rpm-ostree install \
  mesa-va-drivers-freeworld \
  mesa-vdpau-drivers-freeworld.x86_64 \
  libaacs \
  libbdplus \
  libbluray

curl -Lo /etc/yum.repos.d/_copr_sentry-switcheroo-control_discrete.repo https://copr.fedorainfracloud.org/coprs/sentry/switcheroo-control_discrete/repo/fedora-"${RELEASE}"/sentry-switcheroo-control_discrete-fedora-"${RELEASE}".repo
rpm-ostree override replace \
  --experimental \
  --from repo=copr:copr.fedorainfracloud.org:sentry:switcheroo-control_discrete \
    switcheroo-control
