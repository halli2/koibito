## 1. BUILD ARGS
# These allow changing the produced image by passing different build args to adjust
# the source from which your image is built.
# Build args can be provided on the commandline when building locally with:
#   podman build -f Containerfile --build-arg FEDORA_VERSION=40 -t local-image

ARG SOURCE_IMAGE="base"
ARG SOURCE_SUFFIX="-main"
ARG SOURCE_TAG="latest"

FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}

# /var/lib/alternatives is required to prevent failure with some RPM installs
RUN mkdir -p /var/lib/alternatives && \
    ostree container commit

COPY steam /tmp/steam/
WORKDIR /tmp/steam/
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    ./steam_extras.sh && \
    ostree container commit

COPY jp /tmp/jp/
WORKDIR /tmp/jp/
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    ./build.sh && \
    ostree container commit

# CURRENTLY GREETD NEED TO BE BEFORE WM's
COPY greetd /tmp/greetd
WORKDIR /tmp/greetd
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    ./build.sh && \
    ostree container commit

COPY sway /tmp/sway
WORKDIR /tmp/sway
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    ./build.sh && \
    ostree container commit

COPY hyprland /tmp/hyprland
WORKDIR /tmp/hyprland
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    ./build.sh && \
    ostree container commit

WORKDIR /

COPY build_dev.sh /tmp/build_dev.sh
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    /tmp/build_dev.sh && \
    ostree container commit

COPY build_base.sh /tmp/build_base.sh
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    /tmp/build_base.sh && \
    ostree container commit

# TODO: Cleanup in script
# TODO: Install flatpaks? Or just add a justfile for this?
COPY system_files/usr /
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    rpm-ostree override remove \
        firefox \
        firefox-langpacks && \
    ostree container commit

## NOTES:
# - All RUN commands must end with ostree container commit
#   see: https://coreos.github.io/rpm-ostree/container/#using-ostree-container-commit
