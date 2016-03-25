#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

which nix-env &> /dev/null

nix-env -i chromium

if [ -d ${HOME}/.local/share/applications ]; then
  cp $(nix-env -q chromium --out-path | awk '{print $2}')/share/applications/chromium.desktop ~/.local/share/applications/
fi
