#!/bin/bash
# create bootable iso for milanY

ROOTFS="$1"
ISO_NAME="$2"

if [ -z "$ROOTFS" ] || [ -z "$ISO_NAME" ]; then
    echo "usage: $0 <rootfs_dir> <iso_name>"
    exit 1
fi

echo "creating iso: $ISO_NAME"

# create work directory
WORK_DIR=$(mktemp -d)
ISO_DIR="$WORK_DIR/iso"

mkdir -p "$ISO_DIR"

# copy rootfs to iso
cp -r "$ROOTFS" "$ISO_DIR/milany"

# create boot configuration
mkdir -p "$ISO_DIR/boot/grub"
cat > "$ISO_DIR/boot/grub/grub.cfg" << EOF
set timeout=5
set default=0

menuentry "milanY Linux" {
    linux /boot/vmlinuz-linux-hardened root=/dev/sr0 quiet splash
    initrd /boot/initramfs-linux-hardened.img
}

menuentry "milanY Linux (safe mode)" {
    linux /boot/vmlinuz-linux-hardened root=/dev/sr0 single
    initrd /boot/initramfs-linux-hardened.img
}
EOF

# create iso using xorriso
xorriso -as mkisofs \
    -iso-level 3 \
    -full-iso9660-filenames \
    -volid "milanY" \
    -eltorito-boot boot/grub/i386-pc/eltorito.img \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -output "$ISO_NAME" \
    "$ISO_DIR"

# cleanup
rm -rf "$WORK_DIR"

echo "iso created: $ISO_NAME"
