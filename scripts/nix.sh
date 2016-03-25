#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

[ ${UID} -ne 0 ]
cd "${HOME}"
[ -w . ]

curl https://nixos.org/nix/install > nix_installer
sh nix_installer
rm -f nix_installer
