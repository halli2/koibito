ARG FEDORA_MAJOR_VERSION=40

FROM ghcr.io/ublue-os/akmods:fsync-${FEDORA_MAJOR_VERSION} AS akmods
FROM ghcr.io/ublue-os/akmods-extra:fsync-${FEDORA_MAJOR_VERSION} AS akmods-extra
FROM ghcr.io/ublue-os/fsync-kernel:${FEDORA_MAJOR_VERSION} AS fsync

FROM ghcr.io/ublue-os/base-main:${FEDORA_MAJOR_VERSION} AS koibito

RUN mkdir -p /usr/libexec/containerbuild
COPY cleanup.sh /usr/libexec/containerbuild/cleanup.sh

# Update packages that commonly cause build issues
COPY build_scripts/override_packages.sh /tmp/override_packages.sh
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    /tmp/override_packages.sh && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# TODO: Move to where they are used?
# Setup Copr repos
COPY build_scripts/coprs.sh /tmp/coprs.sh
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    /tmp/coprs.sh && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# FSYNC-KERNEL
COPY build_scripts/fsync.sh /tmp/fsync.sh
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    --mount=type=bind,from=fsync,src=/tmp/rpms,dst=/tmp/fsync-rpms \
    /tmp/fsync.sh && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# AKMODS
COPY build_scripts/akmods.sh /tmp/akmods.sh
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    --mount=type=bind,from=akmods,src=/rpms,dst=/tmp/akmods-rpms \
    --mount=type=bind,from=akmods-extra,src=/rpms,dst=/tmp/akmods-extra-rpms \
    /tmp/akmods.sh && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# TODO: Is it possible to not use all these patches?
# Install Valve's patched Mesa, Pipewire, Bluez, and Xwayland
# Install patched switcheroo control with proper discrete GPU support
COPY build_scripts/patches.sh /tmp/patches.sh
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    /tmp/patches.sh && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Install Steam & Lutris, plus supporting packages
COPY build_scripts/steam.sh /tmp/steam.sh
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    /tmp/steam.sh && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Remove unneeded packages
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    rpm-ostree override remove \
        ublue-os-update-services \
        firefox \
        firefox-langpacks && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Install packages
COPY build_scripts/koibito.sh /tmp/koibito.sh
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    /tmp/koibito.sh && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# CURRENTLY GREETD NEED TO BE BEFORE WM's
COPY greetd /tmp/greetd
WORKDIR /tmp/greetd
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    ./build.sh && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# COPY sway /tmp/sway
# WORKDIR /tmp/sway
# RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
#     ./build.sh && \
#     /usr/libexec/containerbuild/cleanup.sh && \
#     ostree container commit

COPY hyprland /tmp/hyprland
WORKDIR /tmp/hyprland
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    ./build.sh && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

WORKDIR /

COPY build_scripts/dev_packages.sh /tmp/dev_packages.sh
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    /tmp/dev_packages.sh && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

COPY build_scripts/gamescope.sh /tmp/gamescope.sh
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    /tmp/gamescope.sh && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# TODO: Cleanup in script
# TODO: Install flatpaks? Or just add a justfile for this?

