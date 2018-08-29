#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail



[ -f "/home/${NEWUSERLOGIN}/${NETBEANS_FILENAME}" ]

/home/${NEWUSERLOGIN}/${NETBEANS_FILENAME} --silent

[ -f "/home/${NEWUSERLOGIN}/netbeans-8.2/etc/netbeans.conf" ]

sed -i 's|^netbeans_jdkhome=.*|netbeans_jdkhome="/usr/java/latest"|' "/home/${NEWUSERLOGIN}/netbeans-8.2/etc/netbeans.conf"

# Desktop is not created until after graphical login
ln -s "/home/${NEWUSERLOGIN}/netbeans-8.2/bin/netbeans" "/home/${NEWUSERLOGIN}/netbeans8.2_launcher"
