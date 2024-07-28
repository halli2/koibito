#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

# Add ublue packages, add needed negativo17 repo and then immediately disable due to incompatibility with RPMFusion

curl -Lo /etc/yum.repos.d/_copr_hikariknight-looking-glass-kvmfr.repo https://copr.fedorainfracloud.org/coprs/hikariknight/looking-glass-kvmfr/repo/fedora-"${RELEASE}"/hikariknight-looking-glass-kvmfr-fedora-"${RELEASE}".repo
curl -Lo /etc/yum.repos.d/_copr_rok-cdemu.repo https://copr.fedorainfracloud.org/coprs/rok/cdemu/repo/fedora-"${RELEASE}"/rok-cdemu-fedora-"${RELEASE}".rep


ENABLED_AKMODS=(
    # /tmp/akmods-rpms/kmods/*kvmfr*.rpm
    # /tmp/akmods-rpms/kmods/*xone*.rpm
    # /tmp/akmods-rpms/kmods/*openrazer*.rpm
    # /tmp/akmods-rpms/kmods/*v4l2loopback*.rpm
    # /tmp/akmods-rpms/kmods/*wl*.rpm
    # /tmp/akmods-rpms/kmods/*evdi*.rpm
    # /tmp/akmods-rpms/kmods/*framework-laptop*.rpm
    # /tmp/akmods-extra-rpms/kmods/*gcadapter_oc*.rpm
    # /tmp/akmods-extra-rpms/kmods/*nct6687*.rpm
    # /tmp/akmods-extra-rpms/kmods/*zenergy*.rpm
    # /tmp/akmods-extra-rpms/kmods/*vhba*.rpm
    # /tmp/akmods-extra-rpms/kmods/*ayaneo-platform*.rpm
    # /tmp/akmods-extra-rpms/kmods/*ayn-platform*.rpm
    # /tmp/akmods-extra-rpms/kmods/*bmi260*.rpm
    /tmp/akmods-extra-rpms/kmods/*ryzen-smu*.rpm
)

sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_ublue-os-akmods.repo
curl -Lo /etc/yum.repos.d/negativo17-fedora-multimedia.repo https://negativo17.org/repos/fedora-multimedia.repo

rpm-ostree install "${ENABLED_AKMODS[@]}"

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo
# rpm-ostree override replace \
#     --experimental \
#     --from repo=copr:copr.fedorainfracloud.org:ublue-os:staging \
#         fwupd \
#         fwupd-plugin-flashrom \
#         fwupd-plugin-modem-manager \
#         fwupd-plugin-uefi-capsule-data
