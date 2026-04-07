#!/bin/bash
# setup init system and services for milanY

ROOTFS="$1"

if [ -z "$ROOTFS" ]; then
    echo "usage: $0 <rootfs_dir>"
    exit 1
fi

echo "configuring systemd services"

# enable essential services
arch-chroot "$ROOTFS" systemctl enable NetworkManager
arch-chroot "$ROOTFS" systemctl enable systemd-timesyncd
arch-chroot "$ROOTFS" systemctl enable firejail
arch-chroot "$ROOTFS" systemctl enable fail2ban
arch-chroot "$ROOTFS" systemctl enable tor
arch-chroot "$ROOTFS" systemctl enable dnscrypt-proxy
arch-chroot "$ROOTFS" systemctl enable unbound

# disable unnecessary services for privacy
arch-chroot "$ROOTFS" systemctl disable systemd-journald-upload
arch-chroot "$ROOTFS" systemctl disable systemd-networkd-wait-online
arch-chroot "$ROOTFS" systemctl disable systemd-resolved

# setup custom milanY services
cp "$(dirname "$0")/../etc/systemd/system/milany-wallpaper.service" "$ROOTFS/etc/systemd/system/"
cp "$(dirname "$0")/../etc/systemd/system/milany-privacy.service" "$ROOTFS/etc/systemd/system/"

arch-chroot "$ROOTFS" systemctl enable milany-wallpaper.service
arch-chroot "$ROOTFS" systemctl enable milany-privacy.service

# configure kernel hardening
echo "vm.swappiness=10" >> "$ROOTFS/etc/sysctl.d/99-milany.conf"
echo "net.ipv4.ip_forward=0" >> "$ROOTFS/etc/sysctl.d/99-milany.conf"
echo "net.ipv6.conf.all.accept_ra=0" >> "$ROOTFS/etc/sysctl.d/99-milany.conf"
echo "kernel.dmesg_restrict=1" >> "$ROOTFS/etc/sysctl.d/99-milany.conf"
echo "kernel.kptr_restrict=2" >> "$ROOTFS/etc/sysctl.d/99-milany.conf"

echo "init system setup complete"
