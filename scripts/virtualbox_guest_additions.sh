#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

# Where to mount the ISO
MNTDIR="/mnt"
# Where we expect the ISO to be
VBOXGUESTADDSISO="/tmp/VBoxGuestAdditions.iso"

# Verify the ISO is present
[ -f "${VBOXGUESTADDSISO}" ]
# Verify MNTDIR exists, is a directory, and is not currently mounted
[ -d "${MNTDIR}" ] && ! mountpoint "${MNTDIR}"
mount -o loop "${VBOXGUESTADDSISO}" "${MNTDIR}"

# Packages needed to compile VBoxGuestAdditions.
# EPEL is needed for dkms.
yum -y install \
  dkms gcc gcc-c++ make nfs-utils perl wget \
  {kernel,openssl,readline,sqlite,zlib}-devel

# MAKE='gmake -i' is needed to successfully build OpenGL.
MAKE='/usr/bin/gmake -i' /mnt/VBoxLinuxAdditions.run || true

umount "${MNTDIR}"
rm -f "${VBOXGUESTADDSISO}"
