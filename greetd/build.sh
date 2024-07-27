#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# Copy greetd selinux workaround and greetd config
cp -r usr /

# Create greeter user
# I think it *should* work using the greetd user and not doing this, but it doesnt.
useradd -M greeter

PACKAGES=(
    greetd
    cage
    gtkgreet
)

rpm-ostree install "${PACKAGES[@]}"

systemctl enable greetd
systemctl enable greetd-workaround
