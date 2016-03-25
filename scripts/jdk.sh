#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

cd "${HOME}"

#URL="http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm"
URL="http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.rpm"
#URL="http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.rpm"
FILENAME="$(basename "${URL}")"
curl -f -L -H 'Cookie: oraclelicense=accept-securebackup-cookie' "${URL}" > "${FILENAME}"
rpm -qp "${FILENAME}" -K
if [ ${EUID} -eq 0 ]; then
  yum -y install "${FILENAME}"
else
  sudo yum -y install "${FILENAME}"
fi
