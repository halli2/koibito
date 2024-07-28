#!/bin/bash
set -ouex pipefail

PACKAGES=(
  gamescope
  # gamescope-libs.i686
  # gamescope-shaders
  # gamescope-legacy

  gamescope-session-plus
  # gamescope-session-steam
)

rpm-ostree install "${PACKAGES[@]}"
