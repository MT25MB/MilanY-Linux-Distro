# milanY linux

privacy focused linux distribution for the digital shadows

## about

milanY is a minimalist privacy-focused linux distribution built for anonymity, cybersecurity, and digital freedom. designed for hackers, security researchers, and privacy advocates who need a secure operating system that doesn't compromise on functionality.

## features

### privacy & security
- full disk encryption support
- tor integration with circuit management
- dnscrypt-proxy for encrypted dns
- hardened kernel with security patches
- apparmor profiles for application sandboxing
- firewall with deny-by-default policy
- automatic privacy cleanup tools

### desktop environment
- i3-gaps window manager with cyberpunk theme
- customized rofi launcher with futuristic interface
- picom compositing with blur effects
- alacritty terminal with transparency
- minimal resource usage for maximum performance

### ai integration
- gemini ai assistant for security analysis
- threat intelligence integration
- privacy advisor and crypto helper
- system analysis with ai recommendations

### live features
- dynamic wallpaper with weather display
- real-time news feed integration
- system status monitoring
- customizable information overlay

## installation

1. download the milanY iso
2. boot from usb or cd
3. run `./install.sh` as root
4. follow the setup wizard
5. configure your gemini api key for ai features

## quick start

after installation:

```bash
# start ai assistant
milany-ai-assistant

# analyze system security
milany-ai-assistant analyze

# get privacy advice
milany-ai-assistant privacy "anonymous browsing"

# threat intelligence
milany-ai-assistant threat "recent vulnerabilities"

# manual privacy cleanup
sudo milany-privacy-cleanup

# regenerate wallpaper
milany-wallpaper
```

## configuration

main config file: `/etc/milany/milany.conf`

key settings:
- `GEMINI_API_KEY` - your gemini api key
- `ENABLE_TOR` - enable tor integration
- `ENABLE_DNSCRYPT` - enable encrypted dns
- `WEATHER_ENABLED` - live weather on wallpaper
- `NEWS_ENABLED` - news feed integration

## security features

### kernel hardening
- restricted ptrace access
- disabled exec-shield bypasses
- memory randomization
- restricted core dumps
- sysctl security tuning

### network security
- iptables firewall with strict rules
- tor circuit management
- dns encryption and validation
- mac address randomization
- connection tracking

### application security
- apparmor sandboxing
- firejail application containers
- browser hardening
- temporary filesystem protection

## troubleshooting

### tor not working
```bash
sudo systemctl status tor
sudo systemctl restart tor
```

### dns issues
```bash
sudo systemctl status dnscrypt-proxy
sudo systemctl restart systemd-resolved
```

### wallpaper not updating
```bash
milany-wallpaper --debug
```

## contributing

milanY is a community project focused on digital privacy. contributions welcome in:
- security hardening
- privacy tools
- documentation
- testing

## security notes

⚠️ **important**: milanY contains no hardcoded credentials or api keys. you must configure your own:

- **api keys**: configure in `/etc/milany/milany.conf`
- **gpg keys**: generate with `milany-id-manager create`
- **vpn configs**: add your own vpn configuration files
- **encryption keys**: create with `milany-crypt generate`

### security practices
- all external api calls use https encryption
- local services bind to localhost only (127.0.0.1)
- no hardcoded passwords or secrets in source code
- user data stored in encrypted format
- automatic cleanup of sensitive temporary files

### privacy guarantee
milany is designed to protect your privacy by default:
- no telemetry or data collection
- no forced updates or phone home
- all network traffic can be routed through tor
- encrypted dns by default
- minimal system footprint for reduced attack surface

## contributing

we welcome contributions! please:
- test your changes thoroughly
- follow the existing code style
- update documentation
- ensure no sensitive data is committed
- use descriptive commit messages

### development setup
```bash
# clone the repository
git clone https://github.com/yourusername/milany-linux.git
cd milany-linux

# make scripts executable
chmod +x usr/local/bin/milany-*

# run tests (if available)
./test/run-tests.sh
```

## license

this project is licensed under the mit license - see the [license](license) file for details.

## disclaimer

milanY is provided as-is for educational and research purposes. users are responsible for:
- complying with local laws and regulations
- securing their own encryption keys and credentials
- understanding the privacy implications of their actions
- not using the system for illegal activities

---

**made with ❤️ for digital freedom**  
**channel: [down with big brother](https://www.youtube.com/channel/ucgj29l7jsaklicws0klt3w)**

## disclaimer

milanY is provided for educational and research purposes. users are responsible for complying with local laws and regulations.

---

*enter the shadows*
