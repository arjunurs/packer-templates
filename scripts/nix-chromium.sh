#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail


#which nix-env &> /dev/null
nix-env -i chromium

umask 0022
mkdir -p ${HOME}/.local/share/applications
DESKTOP_SHORTCUT="$(nix-env -q chromium --out-path | awk '{print $2}')/share/applications/chromium.desktop"
