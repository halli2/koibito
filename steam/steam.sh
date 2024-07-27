#!/bin/bash

set -ouex pipefail
RELEASE="$(rpm -E %fedora)"

### Try to install steam...
