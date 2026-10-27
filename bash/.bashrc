# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.
# Silence the standalone system tTY tool reporting errors during Yakuake tab mapping
if [[ "$TERM" == "xterm-256color" || "$yakuake" || "$KONSOLE_VERSION" ]]; then
    function tty() {
        command tty "$@" 2>/dev/null
    }
fi
#

# =========================================
# starts blesh but dose not  attach (will attach at bottom of file requires you to have blesh installed or just comment out this line and the blesh line at end of this file)
# Source ble.sh at the top of ~/.bashrc
# =========================================
[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach
#
# source ~/.local/share/blesh/ble.sh

# =========================================
# test for alias file if it exists
# =========================================
test -s ~/.alias && . ~/.alias || true

# =========================================
# Import custom aliases if the file exists
# =========================================
if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

if [ -f "$HOME/.bash_aliases_local" ]; then
    . "$HOME/.bash_aliases_local"
fi

# Support colors in less

# export MANPAGER="less -R --use-color -Dd+r -Du+b"
#
export PAGER="most"
# export LESS_TERMCAP_mb=$'\e[1;31m'
# export LESS_TERMCAP_md=$'\e[1;31m'
# export LESS_TERMCAP_me=$'\e[0m'
# export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[1;33;44m'
# export LESS_TERMCAP_ue=$'\e[0m'
# export LESS_TERMCAP_us=$'\e[4;1;32m'
# export LESS_TERMCAP_mr=$'\e[7m'
# export LESS_TERMCAP_mh=$'\e[2m'
# export LESS_TERMCAP_ZN=$'\e[74m'
# export LESS_TERMCAP_ZV=$'\e[75m'
# export LESS_TERMCAP_ZO=$'\e[73m'
# export LESS_TERMCAP_ZW=$'\e[75m'

# =========================================
# Place your personal configs in a seprate folder and call them here by using the source call ore the short hand . Call
# =========================================
# source /path/to/your/config.file
# or
# . /path/to/your/config.file

# ========================================
# call powerline-go configs.
# ========================================
# Check if the external configuration file exists before loading it
if [ -f ~/.powerlineconfig.sh ]; then

    source ~/.powerlineconfig.sh
fi

# ==========================================
# Attach ble.sh at the bottom of ~/.bashrc comment out if you don't use blesh, make sure this stays at the bottom of this file
# ==========================================
[[ ${BLE_VERSION-} ]] && ble-attach
