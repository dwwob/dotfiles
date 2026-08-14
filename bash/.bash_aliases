# ==========================================
# SYSTEM NAVIGATION
# ==========================================
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias home="cd ~"

# ==========================================
# BETTER DEFAULT COMMANDS
# ==========================================
# Force colors, human-readable sizes, and show hidden files
alias ls="ls --color=auto"
alias ll="ls -lahF"
alias la="ls -A"
alias ld="ls -a"

alias bistro="cd ~/Documents/learning/Programing/learning-html/bistro/"

alias grep="grep --color=auto"

# Safety nets to confirm file deletions/overwrites
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# ==========================================
# SYSTEM MANAGEMENT
# ==========================================
# Quick reload of the shell configuration
alias reload="source ~/.bashrc"
alias cls="clear"

# Ubuntu/Debian update shorthand (optional)
alias update="sudo zypper dup "

# ==========================================
# DEVELOPER TOOLS (GIT)
# ==========================================
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m "
alias gp="git push -u origin main"
alias gl="git log --oneline --graph --decorate"



#function _update_ps1() {
 #   PS1=$(powerline-shell $?)
#}

#if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

# Powerline daemon and bash binding integration



# echo -e '\n# Powerline-Go Bash Setup\nfunction _update_ps1() {\n    PS1="$($(which powerline-go) -error $?)"\n}\nif [ "$TERM" != "linux" ] && [ -f "$(which powerline-go)" ]; then\n    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"\nfi' >> ~/.bashrc
#

