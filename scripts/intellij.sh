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

INTELLIJ_URL="https://download.jetbrains.com/idea/ideaIC-2016.2.5.tar.gz"
INTELLIJ_FILENAME="$(basename "${INTELLIJ_URL}")"
#INTELLIJ_SHA256='9e3e0f4538707da37237106697fff4e0b5ed651085f456671764e1fbc9651bbe'

#curl -L "${INTELLIJ_URL}" > "${INTELLIJ_FILENAME}"
[ -f "${INTELLIJ_FILENAME}" ]
#echo "${INTELLIJ_SHA256}  ${INTELLIJ_FILENAME}" | sha256sum -c
EXTRACTDIR="$(dirname $(tar -ztf "${INTELLIJ_FILENAME}" | head -n1))"
tar -zxf "${INTELLIJ_FILENAME}"
[ -f "${HOME}/${EXTRACTDIR}/bin/idea.sh" ]
ln -s "${HOME}/${EXTRACTDIR}/bin/idea.sh" "${HOME}/Desktop/IntelliJ"
