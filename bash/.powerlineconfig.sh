# ==============================================================================
# Powerline-go Initialization Configuration
# Optimized for Bash, openSUSE Tumbleweed, and Nerd Fonts
# ==============================================================================

# Find the absolute binary path (checks system path first, then falls back to GOPATH)
if [ -x "${GOPATH}/bin/powerline-go" ]; then
    POWERLINE_BIN="${GOPATH}/bin/powerline-go"
elif command -v powerline-go >/dev/null 2>&1; then
    POWERLINE_BIN=$(command -v powerline-go)
fi

# Initialize if powerline-go is found and not running in a plain linux TTY console
if [ -n "${POWERLINE_BIN}" ] && [ "${TERM}" != "linux" ]; then
    
    function _update_ps1() {
        # Keep the exit status local to prevent internal overwrites
        local EXIT_CODE=$?
        
        # Count active background jobs safely while suppressing potential TTY device errors
        local JOBS_COUNT=$(jobs -p 2>/dev/null | wc -l)
        
        # Render the custom powerline-go prompt layout
        # -modules: Specifies visible layout segments
        # -git-mode fancy: Enables rich status symbols (ahead/behind, stashes, modified)
        # -cwd-max-depth 3: Keeps long directory strings tidy
        PS1="$(${POWERLINE_BIN} -modules "user,host,ssh,cwd,perms,git,exit" -git-mode fancy -error ${EXIT_CODE} -cwd-max-depth 3 -jobs ${JOBS_COUNT})"
    }
    
    # Safely append to PROMPT_COMMAND without causing loop errors if sourced multiple times
    if [ -z "${PROMPT_COMMAND}" ]; then
        PROMPT_COMMAND="_update_ps1"
    elif [[ ";${PROMPT_COMMAND};" != *";_update_ps1;"* ]]; then
        PROMPT_COMMAND="_update_ps1; ${PROMPT_COMMAND%;}"
    fi
fi

