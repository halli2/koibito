#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# Copy greetd selinux workaround and greetd config
cp -r usr /



PACKAGES=(
    greetd
    cage
    gtkgreet
)

rpm-ostree install "${PACKAGES[@]}"

systemctl enable greetd
systemctl enable greetd-workaround
