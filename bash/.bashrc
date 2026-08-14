# Source ble.sh at the top of ~/.bashrc
[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach


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

# test -s ~/.alias && . ~/.alias || true

source ~/.local/share/blesh/ble.sh

# Import custom aliases if the file exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f "${GOPATH}/bin/powerline-go" ]; then
    function _update_ps1() {
        PS1=$("${GOPATH}/bin/powerline-go" -error $? -cwd-max-depth 3 -jobs "$(jobs -p | wc -l)")
    }
    if [ "${TERM}" != "linux" ]; then
        PROMPT_COMMAND="_update_ps1; ${PROMPT_COMMAND}"
    fi
fi


# Attach ble.sh at the bottom of ~/.bashrc
[[ ${BLE_VERSION-} ]] && ble-attach

