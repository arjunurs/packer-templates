#!/bin/bash -x


set -o errexit
set -o nounset
set -o pipefail

# RPM GPG keys can be downloaded from http://yum.oracle.com/RPM-GPG-KEY-oracle-ol6
# see https://yum.oracle.com/faq.html
[ -f /home/vagrant/RPM-GPG-KEY-oracle-ol6 ]
sudo rpm --import /home/vagrant/RPM-GPG-KEY-oracle-ol6
rpm -qp "/home/vagrant/${JDK_FILENAME}" -K
sudo yum -y remove 'java-*-openj*' || /bin/true
sudo yum -y install "${JDK_FILENAME}"
