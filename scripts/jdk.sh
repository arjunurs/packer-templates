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

#URL="http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm"
#URL="http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.rpm"
#URL="http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.rpm"
#URL="http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.rpm"
URL="http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.rpm"
FILENAME="$(basename "${URL}")"
[ -f "${FILENAME}" ]
#curl -f -L -H 'Cookie: oraclelicense=accept-securebackup-cookie' "${URL}" > "${FILENAME}"
rpm -qp "${FILENAME}" -K
sudo yum -y remove 'java-*-openj*' || /bin/true
sudo yum -y install "${FILENAME}"
