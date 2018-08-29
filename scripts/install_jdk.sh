#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

rpm -qp "/home/${NEWUSERLOGIN}/${JDK_FILENAME}" -K
sudo yum -y remove 'java-*-openj*' || /bin/true
sudo yum -y install "${JDK_FILENAME}"
