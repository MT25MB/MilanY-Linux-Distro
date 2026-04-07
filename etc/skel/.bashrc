# milanY bash configuration
# personalized for "Down with Big Brother" channel

# disable history tracking
unset HISTFILE
export HISTSIZE=0
export HISTFILESIZE=0
export HISTCONTROL=ignorespace:erasedups

# security settings
umask 077
ulimit -c 0

# disable shell tracking
export LESSHISTFILE=-
export W3M_DIR=/dev/null
export NODE_REPL_HISTORY=/dev/null

# milanY environment
export MILANY_VERSION="1.0.0"
export MILANY_CONFIG="/etc/milany/milany.conf"

# paths
export PATH="$PATH:/usr/local/bin:/opt/milany/bin"
export EDITOR="vim"
export BROWSER="firefox"
export TERMINAL="alacritty"

# prompt with personalized colors
milany_prompt() {
    local exit_code=$?
    local user_color='\033[0;95m'      # purple
    local host_color='\033[0;94m'      # blue
    local dir_color='\033[0;96m'       # cyan
    local error_color='\033[0;91m'      # red
    local reset='\033[0m'
    
    if [ $exit_code -eq 0 ]; then
        local prompt_symbol='λ'
    else
        local prompt_symbol="${error_color}λ${reset}"
    fi
    
    PS1="${user_color}\u${reset}@${host_color}\h${reset}:${dir_color}\w${reset} ${prompt_symbol} "
}

PROMPT_COMMAND=milany_prompt

# aliases for privacy tools
alias tor='systemctl restart tor && echo "tor circuits renewed"'
alias privacy='milany-privacy-cleanup'
alias ai='milany-ai-assistant'
alias wall='milany-wallpaper'
alias scan='milany-scan'
alias encrypt='milany-crypt encrypt'
alias tunnel='milany-proxy'

# network aliases
alias ipinfo='curl ipinfo.io'
alias myip='curl ifconfig.me'
alias ports='ss -tuln'
alias connections='ss -tuln'

# security aliases
alias checkroot='sudo -i whoami'
alias audit='sudo lynis audit system'
alias vulns='sudo chkrootkit'

# file aliases
alias shred='milany-crypt shred'
alias wipe='sudo wipe -rfi'
alias secure='chmod 600'

# system aliases
alias update='sudo pacman -Syu'
alias clean='sudo pacman -Scc'
alias logs='journalctl -f'
alias services='systemctl list-units --type=service --state=running'

# development aliases
alias dev='cd ~/dev'
alias build='make'
alias test='make test'
alias deploy='make deploy'

# quick shortcuts
alias q='exit'
alias c='clear'
alias l='ls -la'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'

# functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# secure temp
secure_tmp() {
    local tmpdir=$(mktemp -d -t milany.XXXXXX)
    chmod 700 "$tmpdir"
    cd "$tmpdir"
    echo "secure temp directory: $tmpdir"
}

# auto-run privacy setup on login
if [ -f /usr/local/bin/milany-user-privacy ]; then
    /usr/local/bin/milany-user-privacy
fi

# personalized welcome message
echo -e "\033[0;95mwelcome to milanY linux v$MILANY_VERSION\033[0m"
echo -e "\033[0;94mdown with big brother - privacy focused\033[0m"
echo -e "\033[0;96menhanced privacy mode active\033[0m"
echo -e "\033[0;95mtype 'help' for available commands\033[0m"
