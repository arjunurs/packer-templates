#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

[ $UID -ne 0 ]
cd "${HOME}"

NETBEANS_URL="http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-javase-linux.sh"
NETBEANS_FILENAME="$(basename "${NETBEANS_URL}")"
NETBEANS_MD5="dfa4af8f4a1fe88e3f8dea6b646882a7"

curl -f -L "${NETBEANS_URL}" > "${NETBEANS_FILENAME}"
echo "${NETBEANS_MD5}  ${NETBEANS_FILENAME}" | md5sum -c
which java &>/dev/null
sh netbeans-8.1-javase-linux.sh --silent
