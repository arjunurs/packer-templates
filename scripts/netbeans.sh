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

NETBEANS_URL="http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-javase-linux.sh"
NETBEANS_FILENAME="$(basename "${NETBEANS_URL}")"
NETBEANS_MD5="dfa4af8f4a1fe88e3f8dea6b646882a7"

#curl -f -L "${NETBEANS_URL}" > "${NETBEANS_FILENAME}"
[ -f "${NETBEANS_FILENAME}" ]
echo "${NETBEANS_MD5}  ${NETBEANS_FILENAME}" | md5sum -c
which java &>/dev/null
sh netbeans-8.1-javase-linux.sh --silent
