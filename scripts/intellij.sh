#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

[ $UID -ne 0 ]

cd "${HOME}"

INTELLIJ_URL="https://download.jetbrains.com/idea/ideaIC-2016.1.tar.gz"
INTELLIJ_FILENAME="$(basename "${INTELLIJ_URL}")"
INTELLIJ_SHA256='d8d889c42dfde1f41030e9d3f5850d364109df73a6a35081edc72d7d95f22fbf'

curl -L "${INTELLIJ_URL}" > "${INTELLIJ_FILENAME}"
echo "${INTELLIJ_SHA256}  ${INTELLIJ_FILENAME}" | sha256sum -c
EXTRACTDIR="$(dirname $(tar -ztf "${INTELLIJ_FILENAME}" | head -n1))"
tar -zxf "${INTELLIJ_FILENAME}"
[ -f "${HOME}/${EXTRACTDIR}/bin/idea.sh" ]
ln -s "${HOME}/${EXTRACTDIR}/bin/idea.sh" "${HOME}/Desktop/IntelliJ"
