#!/bin/bash
# build hardened kernel for milanY

ROOTFS="$1"

if [ -z "$ROOTFS" ]; then
    echo "usage: $0 <rootfs_dir>"
    exit 1
fi

echo "building hardened kernel"

# use linux-hardened package
pacstrap -K "$ROOTFS" linux-hardened linux-hardened-headers

# configure kernel modules for privacy
cat > "$ROOTFS/etc/modprobe.d/milany-blacklist.conf" << EOF
# blacklist modules for privacy
blacklist pcspkr
blacklist snd_pcm_oss
blacklist snd_mixer_oss
blacklist snd_seq_oss
blacklist snd_seq_device
blacklist bluetooth
blacklist uvcvideo
blacklist webcam
EOF

# setup secure boot keys
mkdir -p "$ROOTFS/etc/secureboot"
cat > "$ROOTFS/etc/secureboot/keys.conf" << EOF
# secure boot configuration for milanY
SIGN_KEY="/etc/secureboot/milany.key"
SIGN_CERT="/etc/secureboot/milany.crt"
EOF

echo "kernel build complete"
