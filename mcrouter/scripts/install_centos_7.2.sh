#!/usr/bin/env bash

set -ex

[ -n "$1" ] || ( echo "Install dir missing"; exit 1 )

sudo yum install -y epel-release
sudo yum install -y centos-release-scl

# Install devtoolset version 4 for GCC 5.x
sudo yum install -y devtoolset-4-gcc devtoolset-4-gcc-c++

export CC=/opt/rh/devtoolset-4/root/usr/bin/gcc
export CXX=/opt/rh/devtoolset-4/root/usr/bin/c++

# workaround for:
#
# Transaction check error:
#   file /usr/share/aclocal from install of cmake-3.1.0-1.x86_64 conflicts with file from package filesystem-3.2-21.el7.x86_64
#
sudo yum --downloadonly --downloaddir=$(pwd) install cmake
sudo rpm -ivh --force cmake-*.rpm

sudo yum install -y \
    autoconf \
    binutils-devel \
    bison \
    boost-devel \
    double-conversion-devel \
    flex \
    git \
    gflags-devel \
    glog-devel \
    jemalloc-devel \
    libtool \
    libevent-devel \
    make \
    openssl-devel \
    python-devel \
    ragel

# Install automake-1.15 from Fedora
sudo rpm -Uvh "http://dl.fedoraproject.org/pub/fedora/linux/releases/23/Everything/x86_64/os/Packages/a/automake-1.15-4.fc23.noarch.rpm"

cd "$(dirname "$0")" || ( echo "cd fail"; exit 1 )

./get_and_build_everything.sh centos-7.2 "$@"
