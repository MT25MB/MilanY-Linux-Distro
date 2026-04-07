#!/bin/bash
# milanY linux build script
# privacy focused distro build system

set -e

BUILD_DIR=$(pwd)
ROOTFS="$BUILD_DIR/rootfs"
VERSION="1.0.0"

echo "building milanY linux v$VERSION"

# clean previous builds
if [ -d "$ROOTFS" ]; then
    rm -rf "$ROOTFS"
fi

mkdir -p "$ROOTFS"

# create base filesystem structure
mkdir -p "$ROOTFS"/{boot,dev,etc,home,media,mnt,opt,proc,root,run,sbin,srv,sys,tmp,usr,var}
mkdir -p "$ROOTFS"/usr/{bin,lib,local,sbin,share,src}
mkdir -p "$ROOTFS"/var/{cache,lib,local,log,opt,spool,tmp}

# copy config files
cp -r etc/* "$ROOTFS/etc/"

# install core packages
echo "installing core packages"
./scripts/install_core_packages.sh "$ROOTFS"

# setup init system
echo "setting up init system"
./scripts/setup_init.sh "$ROOTFS"

# build kernel modules
echo "building kernel"
./scripts/build_kernel.sh "$ROOTFS"

# create iso
echo "creating bootable iso"
./scripts/create_iso.sh "$ROOTFS" "milanY-$VERSION.iso"

echo "build complete ISO ready at milanY-$VERSION.iso"
