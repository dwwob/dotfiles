# =========================================
# Checks for powerline-go and starts if installed
# =========================================
if [ -f "${GOPATH}/bin/powerline-go" ]; then
  function _update_ps1() {
    PS1=$("${GOPATH}/bin/powerline-go" -error $? -cwd-max-depth 3 -jobs "$(jobs -p | wc -l)")
  }
  if [ "${TERM}" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; ${PROMPT_COMMAND}"
  fi
fi
