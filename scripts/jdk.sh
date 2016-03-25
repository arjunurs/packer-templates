#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

[ ${UID} -ne 0 ]
cd "${HOME}"

URL="http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm"
FILENAME="$(basename "${URL}")"
curl -f -L -H 'Cookie: oraclelicense=accept-securebackup-cookie' "${URL}" > "${FILENAME}"
rpm -qp "${FILENAME}" -K
sudo yum -y install "${FILENAME}"
