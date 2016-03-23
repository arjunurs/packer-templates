#!/bin/bash -x

set -o errexit
set -o nounset
set -o pipefail

# Set the default runlevel to 5 (graphical boot)
sed -i 's|^id:3:initdefault:$|id:5:initdefault:|' /etc/inittab

# Packages for UI
yum -y --setopt=group_package_types=mandatory,default groupinstall 'desktop'
yum -y --setopt=group_package_types=mandatory,default groupinstall 'desktop platform'
yum -y --setopt=group_package_types=mandatory,default groupinstall 'fonts'
yum -y --setopt=group_package_types=mandatory,default groupinstall 'general purpose desktop'
yum -y --setopt=group_package_types=mandatory,default groupinstall 'graphical administration tools'
yum -y --setopt=group_package_types=mandatory,default groupinstall 'internet browser'
yum -y --setopt=group_package_types=mandatory,default groupinstall 'x window system'
