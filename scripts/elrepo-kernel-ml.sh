#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

# Install the latest kernel-ml (mainline kernel) from elrepo's elrepo-kernel yum
# repository
yum -y install http://www.elrepo.org/elrepo-release-6-6.el6.elrepo.noarch.rpm
# Install kernel-ml-devel as its needed for when guest additions are compiled
yum -y --enablerepo=elrepo-kernel install kernel-ml kernel-ml-devel
/sbin/grubby --set-default=$(ls -1 /boot/vmlinuz-4* | sort | tail -n1)
# cleanup.sh should remove unused kernels but we need to boot into the new
# kernel first
reboot
sleep 30
