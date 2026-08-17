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

#==========================================
# Personal Dir for Learning
# ========================================
alias bistro="cd ~/Documents/learning/Programing/learning-html/bistro/"

# ========================================
# grip color to auto
# ========================================
alias grep="grep --color=auto"

# ========================================
# Safety nets to confirm file deletions/overwrites
# ========================================
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# ==========================================
# SYSTEM MANAGEMENT
# ==========================================
# Quick reload of the shell configuration
alias reload="source ~/.bashrc"
alias cls="clear"

#==========================================
# zypper for opensuse  update shorthand (optional)
# ========================================
alias update="sudo zypper dup "

# ==========================================
# DEVELOPER TOOLS (GIT)
# ==========================================
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m "
alias gp="git push -u origin main"
alias gl="git log --oneline --graph --decorate"
