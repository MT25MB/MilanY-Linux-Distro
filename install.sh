#!/bin/bash
# milanY linux installer
# privacy focused distro installation

set -e

# colors for terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # no color

# installer variables
TARGET_DEVICE=""
HOSTNAME=""
USERNAME=""
PASSWORD=""
GEMINI_KEY=""
TIMEZONE=""
FULL_DISK_ENCRYPTION=true

# ascii art
cat << 'EOF'
 ____  _ _ _   ____      _    _     
|  _ \| (_) | |  _ \    / \  | |    
| |_) | | | | | | | |  / _ \ | |    
|  _ <| | | | | |_| | / ___ \| |___ 
|_| \_\_|_|_| |____(_)_/   \_\_____|
                                      
    privacy focused linux distro
EOF

echo -e "${CYAN}welcome to milanY linux installer${NC}"
echo ""

# check root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}error: this script must be run as root${NC}"
   exit 1
fi

# function to get user input
get_input() {
    local prompt="$1"
    local var_name="$2"
    local default="$3"
    local is_password="$4"
    
    while true; do
        if [ -n "$default" ]; then
            read -p "$prompt [$default]: " input
            input=${input:-$default}
        else
            read -p "$prompt: " input
        fi
        
        if [ -z "$input" ]; then
            echo -e "${RED}this field is required${NC}"
            continue
        fi
        
        if [ "$is_password" = true ]; then
            read -sp "confirm $prompt: " confirm
            echo ""
            if [ "$input" != "$confirm" ]; then
                echo -e "${RED}passwords do not match${NC}"
                continue
            fi
        fi
        
        eval "$var_name='$input'"
        break
    done
}

# function to validate gemini key
validate_gemini_key() {
    local key="$1"
    if [[ ! "$key" =~ ^[a-zA-Z0-9_-]{32,}$ ]]; then
        echo -e "${RED}invalid gemini api key format${NC}"
        return 1
    fi
    return 0
}

# function to list available disks
list_disks() {
    echo -e "${BLUE}available disks:${NC}"
    lsblk -d -o NAME,SIZE,MODEL | grep -E '^sd|^nvme|^vd'
    echo ""
}

# get installation configuration
echo -e "${YELLOW}=== configuration ===${NC}"
list_disks
get_input "target device (e.g /dev/sda)" TARGET_DEVICE
get_input "hostname" HOSTNAME "milany"
get_input "username" USERNAME "user"
get_input "user password" PASSWORD "" true
get_input "timezone" TIMEZONE "America/New_York"

# get gemini key
echo ""
echo -e "${YELLOW}=== ai integration setup ===${NC}"
echo -e "${CYAN}milanY uses gemini ai for intelligent features${NC}"
echo -e "${CYAN}get your api key from: https://makersuite.google.com/app/apikey${NC}"

while true; do
    get_input "gemini api key (optional)" GEMINI_KEY ""
    if [ -z "$GEMINI_KEY" ]; then
        echo -e "${YELLOW}continuing without ai features${NC}"
        break
    fi
    
    if validate_gemini_key "$GEMINI_KEY"; then
        echo -e "${GREEN}gemini key validated${NC}"
        break
    else
        echo -e "${RED}please enter a valid gemini api key${NC}"
        GEMINI_KEY=""
    fi
done

# confirm installation
echo ""
echo -e "${YELLOW}=== installation summary ===${NC}"
echo -e "target device: ${RED}$TARGET_DEVICE${NC}"
echo -e "hostname: $HOSTNAME"
echo -e "username: $USERNAME"
echo -e "timezone: $TIMEZONE"
echo -e "disk encryption: $FULL_DISK_ENCRYPTION"
echo -e "gemini ai: ${GEMINI_KEY:+enabled}${GEMINI_KEY:-disabled}"
echo ""

read -p "continue with installation? [y/N]: " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo -e "${RED}installation cancelled${NC}"
    exit 1
fi

# installation starts here
echo -e "${GREEN}starting installation...${NC}"

# partition disk
echo -e "${BLUE}partitioning disk...${NC}"
sgdisk --zap-all "$TARGET_DEVICE"
sgdisk -n 1:0:+512M -t 1:ef00 "$TARGET_DEVICE"  # efi boot
sgdisk -n 2:0:0 -t 2:8300 "$TARGET_DEVICE"     # root

# format partitions
echo -e "${BLUE}formatting partitions...${NC}"
mkfs.fat -F32 "${TARGET_DEVICE}1"

if [ "$FULL_DISK_ENCRYPTION" = true ]; then
    echo -e "${BLUE}setting up encryption...${NC}"
    cryptsetup luksFormat "${TARGET_DEVICE}2"
    cryptsetup open "${TARGET_DEVICE}2" cryptroot
    mkfs.ext4 /dev/mapper/cryptroot
    ROOT_PART="/dev/mapper/cryptroot"
else
    mkfs.ext4 "${TARGET_DEVICE}2"
    ROOT_PART="${TARGET_DEVICE}2"
fi

# mount filesystem
echo -e "${BLUE}mounting filesystem...${NC}"
mount "$ROOT_PART" /mnt
mkdir -p /mnt/boot
mount "${TARGET_DEVICE}1" /mnt/boot

# install base system
echo -e "${BLUE}installing base system...${NC}"
pacstrap -K /mnt base linux-hardened linux-firmware

# generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# chroot and configure system
echo -e "${BLUE}configuring system...${NC}"
arch-chroot /mnt /bin/bash << EOF
# set timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc

# set locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# set hostname
echo $HOSTNAME > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts

# create user
useradd -m -G wheel,audio,video,storage -s /bin/bash $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
echo "root:$PASSWORD" | chpasswd

# configure sudo
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# install bootloader
pacman -S --noconfirm grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# enable services
systemctl enable NetworkManager
systemctl enable systemd-timesyncd

# setup milanY config
mkdir -p /etc/milany
cat > /etc/milany/milany.conf << CONF
DISTRO_NAME="milanY"
VERSION="1.0.0"
HOSTNAME="$HOSTNAME"
USERNAME="$USERNAME"
TIMEZONE="$TIMEZONE"
GEMINI_API_KEY="$GEMINI_KEY"
WEATHER_ENABLED=true
NEWS_ENABLED=true
LIVE_WALLPAPER=true
ENABLE_TOR=true
ENABLE_DNSCRYPT=true
ENABLE_FIREWALL=true
CONF

EOF

# install milanY packages
echo -e "${BLUE}installing milanY packages...${NC}"
pacstrap -K /mnt i3-wm i3status i3lock dmenu rofi picom alacritty firefox networkmanager tor dnscrypt-proxy

# copy milanY configs
echo -e "${BLUE}copying configuration files...${NC}"
cp -r etc/* /mnt/etc/

# setup initramfs for encryption
if [ "$FULL_DISK_ENCRYPTION" = true ]; then
    echo -e "${BLUE}configuring initramfs for encryption...${NC}"
    arch-chroot /mnt sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block encrypt filesystems keyboard fsck)/' /etc/mkinitcpio.conf
    arch-chroot /mnt mkinitcpio -P
fi

# cleanup and unmount
echo -e "${BLUE}cleaning up...${NC}"
umount -R /mnt
if [ "$FULL_DISK_ENCRYPTION" = true ]; then
    cryptsetup close cryptroot
fi

# installation complete
echo ""
echo -e "${GREEN}=== installation complete ===${NC}"
echo -e "${CYAN}milanY linux has been successfully installed${NC}"
echo ""
echo -e "${YELLOW}next steps:${NC}"
echo "1. reboot your system"
echo "2. remove installation media"
echo "3. boot into your new milanY system"
echo ""
if [ "$FULL_DISK_ENCRYPTION" = true ]; then
    echo -e "${RED}remember: you'll need to enter your encryption password at boot${NC}"
fi
echo ""
echo -e "${CYAN}welcome to the shadows${NC}"
