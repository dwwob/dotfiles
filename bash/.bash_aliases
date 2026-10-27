# =========================================================================
# 🐧 CORE SYSTEM TERMINAL ALIASES & RESTRUCTURING DEFINITIONS
# =========================================================================
#
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

  python3 - "$file" "$today" <<'PY'
import re
import sys
from pathlib import Path

path = Path(sys.argv[1])
today = sys.argv[2]
lines = path.read_text().splitlines(keepends=True)

with open("/dev/tty") as terminal:
    for i, line in enumerate(lines):
        if line.startswith("## 📅 DAILY LOG:"):
            lines[i] = f"## 📅 DAILY LOG: {today}\n"
            continue

        blank_number = 0
        while re.search(r"_{3,}", line):
            blank_number += 1
            label = re.sub(r"^[\s-]*", "", line).split(":", 1)[0]
            prompt = f"{label}"
            if blank_number > 1:
                prompt += f" (blank {blank_number})"

            print(f"{prompt}: ", end="", flush=True)
            answer = terminal.readline().rstrip("\n")

            # Leave this blank and any remaining blanks on the line unchanged.
            if not answer:
                break

            line = re.sub(r"_{3,}", lambda _: answer, line, count=1)
            lines[i] = line

path.write_text("".join(lines))
PY

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
alias reload="source ~/.bashrc && echo '🔄 Bash configuration successfully reloaded!'"
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
# 🩺 AUTOMATED DIABETES DAILY LOG GENERATOR
# =========================================================================
# Appends a blank copy of the daily log template to your meal plan document
# with today's date and immediately opens it in Neovim.
addlog() {
  local LOG_FILE="$HOME/Documents/diabetes_meal_plan.md"
  local TODAY
  TODAY=$(date "+%Y-%m-%d")

  # Ensure the parent directory and file exist safely
  mkdir -p "$(dirname "$LOG_FILE")"
  touch "$LOG_FILE"

  # Check if an entry for today already exists to prevent duplicate headers
  if grep -q "## 📅 DAILY LOG: $TODAY" "$LOG_FILE"; then
    echo "📝 Log entry for today ($TODAY) already exists! Opening file..."
  else
    # Append the template structure cleanly to the bottom of the file
    cat <<EOF >>"$LOG_FILE"

---

## 📅 DAILY LOG: $TODAY

### 🩸 GLUCOSE TRACKING
* **Fasting (Morning):** _____ mg/dL  *(Target: Under 100-130 mg/dL)*
* **Post-Breakfast (2hr):** _____ mg/dL  *(Target: Under 180 mg/dL)*
* **Post-Lunch (2hr):** _____ mg/dL
* **Post-Dinner (2hr):** _____ mg/dL
* **Bedtime:** _____ mg/dL

### 💊 MEDICATION & SYMPTOMS
* **Metformin Dose:** [ ] AM  /  [ ] PM
* **Frequent Urination:** [ ] None  /  [ ] Mild  /  [ ] Active
* **Water Intake:** _____ / 8 Glasses

### 🥗 NUTRITION & CARB INPUT
* **Breakfast:** ____________________________________________________
* **Lunch:** ________________________________________________________
* **Dinner:** _______________________________________________________
* **Snacks:** _______________________________________________________
* **Accidental Carbs/Spikes:** [ ] None / [ ] Yes: _________________

### 🚶 PHYSICAL MOVEMENT
* **Post-Dinner 15-Min Walk:** [ ] Completed  /  [ ] Missed
* **CGM Drop Check:** Started at _____ mg/dL ➡️ Dropped to _____ mg/dL
EOF
    echo "✨ Appended fresh tracking layout for $TODAY!"
  fi

  # Open Neovim and automatically jump straight to today's header block
  nvim "+/## 📅 DAILY LOG: $TODAY" "$LOG_FILE"
}
