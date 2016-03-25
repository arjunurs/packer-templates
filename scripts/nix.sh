#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

# The intention of this block is to recursively call this script without root
# permissions if invoked with sudo. If invoked as root without sudo, bail out.
if [ ${EUID} -eq 0 ]; then
  # Running with root perms. Because of sudo?
  if [ -z "${SUDO_USER:-}" ]; then
    # script executed without sudo
    echo "This script is not meant to run as root" >&2
    exit 1
  else
    # script executed with sudo. recurse as the user that invoked this script
    # so long as that user was not root.
    SUDO_UID="$(id -u "${SUDO_USER}")"
    if [ ${SUDO_UID} -eq 0 ]; then
      echo "This script is not meant to run as root" >&2
      exit 1
    else
      sudo -u "${SUDO_USER}" -i "${0}" ${@}
      exit 0
    fi
  fi
fi

cd "${HOME}"
[ -w . ]

curl https://nixos.org/nix/install > nix_installer
# nixos.org can get hella slow, use a cached copy
sed -i 's/^curl -L "$url" | bzcat/bzcat nix-1.11.2-x86_64-linux.tar.bz2/' nix_installer
sh nix_installer
rm -f nix_installer
