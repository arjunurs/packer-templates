#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

# Install EPEL
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
