#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

[ -f "/home/vagrant/${CLION_FILENAME}" ]

EXTRACTDIR="clion-2018.2.3"

tar -zxf "/home/vagrant/${CLION_FILENAME}"

[ -f "/home/vagrant/${EXTRACTDIR}/bin/clion.sh" ]

# Desktop is not created until after graphical login
ln -s "/home/vagrant/${EXTRACTDIR}/bin/clion.sh" "/home/vagrant/CLion_launcher"
