# MilanY Linux Dependencies

## Core System Dependencies

### Base System
- `base` - Base Arch Linux packages
- `base-devel` - Development tools
- `systemd` - Init system
- `linux` or `linux-hardened` - Kernel

### Boot
- `grub` - Bootloader
- `efibootmgr` - EFI boot management
- `syslinux` or `systemd-boot` - Alternative bootloaders

## Networking Dependencies

### Required
- `iproute2` - IP routing utilities
- `iputils` - Network utilities
- `dnsutils` - DNS tools (dig, nslookup)
- `net-tools` - Legacy network tools
- `networkmanager` - Network manager

### Privacy Networking
- `tor` - TOR daemon
- `dnscrypt-proxy` - Encrypted DNS
- `openresolv` - DNS resolver management

## Security Dependencies

### Firewall & Network Security
- `iptables` - Firewall (legacy)
- `nftables` - Firewall (modern)
- `ufw` - Uncomplicated firewall
- `firewalld` - Dynamic firewall

### Security Tools
- `rkhunter` - Rootkit detection
- `aide` - File integrity monitoring
- `clamav` - Antivirus
- `lynis` - Security auditing
- `audit` - System auditing

### Encryption
- `gnupg` - GNU Privacy Guard
- `gpgme` - GPG middleware library
- `cryptsetup` - LUKS encryption
- `haveged` - Entropy generator

## Desktop Dependencies

### Window Manager
- `i3-wm` or `i3-gaps` - Tiling window manager
- `i3status` - Status bar
- `i3lock` - Screen locker
- `picom` - Compositor

### Applications
- `rofi` - Application launcher
- `dmenu` - Menu application
- `alacritty` - Terminal emulator
- `firefox` - Web browser
- `feh` or `nitrogen` - Wallpaper setters

### Desktop Utilities
- `file-roller` - Archive manager
- `evince` - PDF viewer
- `lxappearance` - Theme manager

## Development Dependencies

### Build Tools
- `git` - Version control
- `make` - Build automation
- `gcc` - C compiler
- `python` - Python runtime

### Scripting
- `bash` - Shell
- `jq` - JSON processor
- `curl` - HTTP client

## MilanY-Specific Tools Dependencies

### Network Tools
- `nmap` - Port scanner
- `tcpdump` - Packet capture
- `wireshark` or `tshark` - Protocol analyzer
- `aircrack-ng` - Wireless tools

### Privacy Tools
- `tor-browser` - Anonymous browser
- `proxychains` - Proxy chaining

### AI Integration
- `python-requests` - HTTP library
- `jq` - JSON processing (for AI responses)

### Forensics
- `foremost` - File carving
- `strings` - Binary analysis (coreutils)
- `dd` - Disk operations (coreutils)

## Optional Dependencies

### Multimedia
- `ffmpeg` - Media processing
- `mpv` - Media player

### Fonts
- `ttf-dejavu` - DejaVu fonts
- `noto-fonts` - Noto fonts

## Installation Commands

```bash
# Core
pacman -S base base-devel systemd linux

# Networking
pacman -S networkmanager iproute2 tor dnscrypt-proxy

# Security
pacman -S iptables gnupg cryptsetup rkhunter

# Desktop
pacman -S i3-wm i3status rofi alacritty firefox

# MilanY Tools
pacman -S nmap tcpdump jq curl python
```

## Verifying Installation

```bash
# Check dependencies
./scripts/check_deps.sh

# Test tool availability
milany-ai-assistant --help
milany-scan --help
```

## Third-Party Dependencies

Some tools may require:
- Gemini API key (AI features)
- VPN provider credentials
- GPG keys (user-generated)
- TOR bridges (optional)

These are configured by the user, not included in the distribution.