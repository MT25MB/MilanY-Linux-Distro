#!/bin/bash
# install core packages for milanY

ROOTFS="$1"

if [ -z "$ROOTFS" ]; then
    echo "usage: $0 <rootfs_dir>"
    exit 1
fi

# source package config
source "$(dirname "$0")/../package.conf"

echo "installing packages to $ROOTFS"

# install core packages first
pacstrap -K "$ROOTFS" "${core_packages[@]}"

# install networking
pacstrap -K "$ROOTFS" "${network_packages[@]}"

# install privacy tools
pacstrap -K "$ROOTFS" "${privacy_packages[@]}"

# install security tools
pacstrap -K "$ROOTFS" "${security_packages[@]}"

# install desktop
pacstrap -K "$ROOTFS" "${desktop_packages[@]}"

# install multimedia
pacstrap -K "$ROOTFS" "${multimedia_packages[@]}"

# install dev tools
pacstrap -K "$ROOTFS" "${dev_packages[@]}"

# generate fstab
genfstab -U "$ROOTFS" >> "$ROOTFS/etc/fstab"

echo "package installation complete"
