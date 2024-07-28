#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# curl -Lo /usr/bin/copr https://raw.githubusercontent.com/ublue-os/COPR-command/main/copr
# chmod +x /usr/bin/copr

curl -Lo /etc/yum.repos.d/_copr_kylegospo-bazzite.repo https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-"${RELEASE}"/kylegospo-bazzite-fedora-"${RELEASE}".repo
curl -Lo /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-"${RELEASE}"/kylegospo-bazzite-multilib-fedora-"${RELEASE}".repo?arch=x86_64
curl -Lo /etc/yum.repos.d/_copr_kylegospo-scx_lavd.repo https://copr.fedorainfracloud.org/coprs/kylegospo/scx_lavd/repo/fedora-"${RELEASE}"/kylegospo-scx_lavd-fedora-"${RELEASE}".repo
# curl -Lo /etc/yum.repos.d/_copr_ublue-os-staging.repo https://copr.fedorainfracloud.org/coprs/ublue-os/staging/repo/fedora-"${RELEASE}"/ublue-os-staging-fedora-"${RELEASE}".repo?arch=x86_64
curl -Lo /etc/yum.repos.d/_copr_kylegospo-latencyflex.repo https://copr.fedorainfracloud.org/coprs/kylegospo/LatencyFleX/repo/fedora-"${RELEASE}"/kylegospo-LatencyFleX-fedora-"${RELEASE}".repo
curl -Lo /etc/yum.repos.d/_copr_kylegospo-obs-vkcapture.repo https://copr.fedorainfracloud.org/coprs/kylegospo/obs-vkcapture/repo/fedora-"${RELEASE}"/kylegospo-obs-vkcapture-fedora-"${RELEASE}".repo?arch=x86_64

# curl -Lo /etc/yum.repos.d/_copr_kylegospo-wallpaper-engine-kde-plugin.repo https://copr.fedorainfracloud.org/coprs/kylegospo/wallpaper-engine-kde-plugin/repo/fedora-"${RELEASE}"/kylegospo-wallpaper-engine-kde-plugin-fedora-"${RELEASE}".repo
# curl -Lo /etc/yum.repos.d/_copr_ycollet-audinux.repo https://copr.fedorainfracloud.org/coprs/ycollet/audinux/repo/fedora-"${RELEASE}"/ycollet-audinux-fedora-"${RELEASE}".repo
# curl -Lo /etc/yum.repos.d/_copr_kylegospo-rom-properties.repo https://copr.fedorainfracloud.org/coprs/kylegospo/rom-properties/repo/fedora-"${RELEASE}"/kylegospo-rom-properties-fedora-"${RELEASE}".repo
# curl -Lo /etc/yum.repos.d/_copr_kylegospo-webapp-manager.repo https://copr.fedorainfracloud.org/coprs/kylegospo/webapp-manager/repo/fedora-"${RELEASE}"/kylegospo-webapp-manager-fedora-"${RELEASE}".repo
# curl -Lo /etc/yum.repos.d/_copr_hhd-dev-hhd.repo https://copr.fedorainfracloud.org/coprs/hhd-dev/hhd/repo/fedora-"${RELEASE}"/hhd-dev-hhd-fedora-"${RELEASE}".repo
# curl -Lo /etc/yum.repos.d/_copr_che-nerd-fonts.repo https://copr.fedorainfracloud.org/coprs/che/nerd-fonts/repo/fedora-"${RELEASE}"/che-nerd-fonts-fedora-"${RELEASE}".repo
# curl -Lo /etc/yum.repos.d/_copr_sentry-switcheroo-control_discrete.repo https://copr.fedorainfracloud.org/coprs/sentry/switcheroo-control_discrete/repo/fedora-"${RELEASE}"/sentry-switcheroo-control_discrete-fedora-"${RELEASE}".repo

# Kmod?
# curl -Lo /etc/yum.repos.d/_copr_hikariknight-looking-glass-kvmfr.repo https://copr.fedorainfracloud.org/coprs/hikariknight/looking-glass-kvmfr/repo/fedora-"${RELEASE}"/hikariknight-looking-glass-kvmfr-fedora-"${RELEASE}".repo
# curl -Lo /etc/yum.repos.d/_copr_mavit-discover-overlay.repo https://copr.fedorainfracloud.org/coprs/mavit/discover-overlay/repo/fedora-"${RELEASE}"/mavit-discover-overlay-fedora-"${RELEASE}".repo
# curl -Lo /etc/yum.repos.d/_copr_matte-schwartz-sunshine.repo https://copr.fedorainfracloud.org/coprs/matte-schwartz/sunshine/repo/fedora-"${RELEASE}"/matte-schwartz-sunshine-fedora-"${RELEASE}".repo
# curl -Lo /etc/yum.repos.d/_copr_rok-cdemu.repo https://copr.fedorainfracloud.org/coprs/rok/cdemu/repo/fedora-"${RELEASE}"/rok-cdemu-fedora-"${RELEASE}".rep
# curl -Lo /etc/yum.repos.d/_copr_rodoma92-kde-cdemu-manager.repo https://copr.fedorainfracloud.org/coprs/rodoma92/kde-cdemu-manager/repo/fedora-"${RELEASE}"/rodoma92-kde-cdemu-manager-fedora-"${RELEASE}".repo
# curl -Lo /etc/yum.repos.d/_copr_rodoma92-rmlint.repo https://copr.fedorainfracloud.org/coprs/rodoma92/rmlint/repo/fedora-"${RELEASE}"/rodoma92-rmlint-fedora-"${RELEASE}".repo
# curl -Lo /etc/yum.repos.d/tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
# sed -i 's@gpgcheck=1@gpgcheck=0@g' /etc/yum.repos.d/tailscale.repo

