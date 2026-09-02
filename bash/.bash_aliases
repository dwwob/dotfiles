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
# =========================================================================
# 📦 DOTFILES & STOW INTEGRATION ALIASES
# =========================================================================
# Jump instantly to your central dotfiles directory repository
alias dot='cd ~/.dotfiles'

# Force a clean Stow refresh on your Neovim configurations recursively
alias dot-sync='cd ~/.dotfiles && stow -R nvim && echo "🔄 Stow symlinks refreshed!"'

# One-click backup sequence: Stows, adds, commits, and pushes your layout to GitHub
# Usage: dot-push "feat: update shortcut mappings"
dot-push() {
    cd ~/.dotfiles || return 1
    stow -R nvim
    git add .
    git commit -m "${1:-'chore: automate dotfiles configuration synchronization update'}"
    git push origin main
}

# =========================================================================
# ⚡ RAPID GIT CORE ALIASES
# =========================================================================
alias gs='git status -sb'                       # Short, high-visibility branch summary status
alias gss='git status'                          # full status
alias gaa='git add'                             # Stage specific asset paths
alias ga='git add .'                          # Stage every single modification locally
alias gc='git commit -m'                       # Commit quickly with an inline message string
alias gp='git push -u origin main'                            # Stream local commits upstream
alias gl='git pull'                            # Fetch and merge remote modifications cleanly
alias gd='git diff'                            # View localized uncommitted syntax delta differences
alias gll="git log --oneline --graph --decorate"

# Advanced tree graph log layout (Perfect for monitoring complex cross-machine merges)
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
#
