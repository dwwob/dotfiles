# =========================================================================
# 🐧 CORE SYSTEM TERMINAL ALIASES & RESTRUCTURING DEFINITIONS
# =========================================================================#
fastfetch
# =========================================================================
# 🩺 MEDICAL & HEALTH WORKFLOW SHORTCUTS
# =========================================================================
# Instantly opens your Type 2 Diabetes Remission Plan inside Neovim
#
mealplan() {
  local template="$HOME/.local/share/mealplan/diabetes_meal_plan_template.md"
  local today file

  today=$(date +%F)
  file="$HOME/Documents/diabetes_log_$today.md"

  if [[ ! -f "$template" ]]; then
    printf 'Template not found: %s\n' "$template" >&2
    return 1
  fi

  # Copy the clean template only when today's log doesn't exist yet.
  if [[ ! -f "$file" ]]; then
    cp "$template" "$file" || return 1
  fi

  # Call the isolated external utility script safely away from blesh
  python3 "$HOME/.local/bin/update_mealplan.py" "$file" "$today"

  nvim "$file"
}
#
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
# Force color, human-readable file sizes, and show hidden files
alias ls="ls --color=auto"
alias l="ls -CF"
alias ll="ls -lahF"
alias la="ls -A"
alias ld="ls -a --color=auto"
alias ff="fastfetch"

# ========================================
# HIGH VISIBILITY PATTERN SEARCHING
# ========================================
alias grep="grep --color=auto"

# ========================================
# ENVIRONMENT SAFETY NETS (CONFIRM CHANGES)
# ========================================
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# ==========================================
# SYSTEM PERFORMANCE & LIFECYCLE MANAGEMENT
# ==========================================
# Quick reload of the shell environment variables and rules
alias reload="clear && source ~/.bashrc && echo '🔄 Bash configuration successfully reloaded!'"
alias cls="clear"

# =========================================================================
# 📦 DOTFILES & GNU STOW REPOSITORY CORE ARCHITECTURE
# =========================================================================
# Jump instantly to your central dotfiles versioning repository
alias dot='cd ~/.dotfiles'

# Force a clean Stow refresh on your Neovim configurations recursively
alias dot-sync='cd ~/.dotfiles && stow -R nvim && echo "🔄 Stow symlinks refreshed!"'

# One-click backup sequence: Stows, adds, commits, and pushes your layout to GitHub
# Note: Uses pushd/popd to snapshot and return you to your starting working folder context.
dot-push() {
  pushd ~/.dotfiles >/dev/null || return 1
  stow -R nvim
  git add .
  git commit -m "${1:-'chore: automate dotfiles configuration synchronization update'}"
  git push origin main
  popd >/dev/null
}

# =========================================================================
# ⚡ RAPID GIT WORKFLOW COMMAND MAPS
# =========================================================================
alias gs='git status -sb'          # Short, high-visibility branch summary status
alias gss='git status'             # Full raw repository status
alias gaa='git add'                # Stage specific targeted asset paths
alias ga='git add .'               # Stage every single modification locally
alias gc='git commit -m'           # Commit quickly with an inline message string
alias gp='git push -u origin main' # Stream local commits upstream to main branch
alias gl='git pull'                # Fetch and merge remote modifications cleanly
alias gd='git diff'                # View localized uncommitted syntax delta differences
alias gll="git log --oneline --graph --decorate"

# Advanced tree graph log layout (Perfect for monitoring complex cross-machine merges)
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# =========================================================================
# 🐳 AUTOMATED WORDPRESS & PODMAN CONTAINER ENVIRONMENT WORKFLOWS
# =========================================================================

# 1. Start your development environment and instantly repair volume locks
wp-start() {
  echo "🚀 Waking up your Podman WordPress infrastructure stack..."
  cd ~/projects/my-wordpress-site || return 1
  podman-compose up -d

  echo "🔒 Overriding container filesystem security masks..."
  podman unshare chown -R 0:33 wp-content
  podman unshare chmod -R 775 wp-content

  echo "✨ Development workspace is fully live at http://localhost:8080"
  echo "🛠️  Neovim permissions successfully unlocked!"
}

# 2. Stop your environment safely to save system resources
wp-stop() {
  echo "🛑 Shutting down container operations gracefully..."
  cd ~/projects/my-wordpress-site || return 1
  podman-compose down
  echo "🔌 Environment suspended."
}

# 3. Snapshot your code adjustments and push them upstream to GitHub
wp-push() {
  pushd ~/projects/my-wordpress-site >/dev/null || return 1
  echo "📦 Running Git workspace track check..."
  git status -sb

  git add .
  git commit -m "${1:-'feat: adjust custom layout architecture properties'}"
  git push origin main

  echo "🚀 Source code successfully secured on GitHub!"
  popd >/dev/null
}
