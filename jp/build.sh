#!/bin/bash

set -ouex pipefail

# Fallback fontconfig to jp
# fcitx5 systemd user service
cp -r usr /

PACKAGES=(
  langpacks-ja
  # Keyboard
  fcitx5
  fcitx5-mozc
  # Text-analyzing
  mecab
  mecab-ipadic
  fontconfig
)

rpm-ostree install "${PACKAGES[@]}"
