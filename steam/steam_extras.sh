#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

rpm-ostree install \
    steam-devices
