#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

[ -f "/home/${NEWUSERLOGIN}/${INTELLIJ_FILENAME}" ]

EXTRACTDIR="$(dirname $(tar -ztf "${INTELLIJ_FILENAME}" | head -n1))"

tar -zxf "/home/${NEWUSERLOGIN}/${INTELLIJ_FILENAME}"

[ -f "/home/${NEWUSERLOGIN}/${EXTRACTDIR}/bin/idea.sh" ]

# Desktop is not created until after graphical login
ln -s "/home/${NEWUSERLOGIN}/${EXTRACTDIR}/bin/idea.sh" "/home/${NEWUSERLOGIN}/IntelliJ_launcher"
