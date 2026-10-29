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

# =========================================================================
# 1. DECORATIONS & PROMPT SETTINGS (Must be processed before ble.sh hooks)
# =========================================================================
export PAGER="most"

# Call powerline-go configs
if [ -f ~/.powerlineconfig.sh ]; then
    source ~/.powerlineconfig.sh
fi

# =========================================================================
# 2. ALIASES & COMPLETIONS
# =========================================================================
test -s ~/.alias && . ~/.alias || true

if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

if [ -f "$HOME/.bash_aliases_local" ]; then
    . "$HOME/.bash_aliases_local"
fi

# =========================================================================
# 3. BLE.SH FULL ENGINE INITIALIZATION (Starts here, attaches at the end)
# =========================================================================
[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach

# This line seals the environment loop and intercepts prompt configurations safely
[[ ${BLE_VERSION-} ]] && ble-attach
