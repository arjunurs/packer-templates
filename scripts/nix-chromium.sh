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

which nix-env &> /dev/null
nix-env -i chromium

# ${HOME}/.local/share/applications gets created on first graphical login. This
# doesn't happen during the build process so we have to create the directory.
umask 0022
mkdir -p ${HOME}/.local/share/applications
DESKTOP_SHORTCUT="$(nix-env -q chromium --out-path | awk '{print $2}')/share/applications/chromium.desktop"
#[ -f "${DESKTOP_SHORTCUT}" ] && cp "${DESKTOP_SHORTCUT}" ${HOME}/.local/share/applications/
