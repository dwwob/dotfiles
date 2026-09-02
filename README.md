# 🌌 daniel's modular dotfiles

A minimal, lightning-fast, and deeply modularized configuration suite managed via **GNU Stow**. This repository acts as a single source of truth for keeping a unified terminal workspace environment across multiple machines.

---

## 📂 Repository Structure

The layout is split natively into independent domains following advanced design patterns. This makes it trivial to tweak specific features without risking breaking changes across the configuration pipeline.

```text
~/dotfiles/
├── .gitignore                # Safely excludes node_modules, cache, & lazy runtime directories
├── README.md                 # System setup documentation (this file)
└── nvim/                     # GNU Stow target package folder
    └── .config/
        └── nvim/
            ├── init.lua              # Ultra-minimal entrypoint orchestrator
            └── lua/
                ├── config/
                │   ├── options.lua   # vim.opt configurations (numbers, wrapped layouts)
                │   ├── keymaps.lua   # Spacebar shortcuts & dynamic <leader>t Toggle group
                │   ├── autocmd.lua   # Native event hooks (loaded after plugin initializations)
                │   └── lazy.lua      # lazy.nvim loader with manual subfolder imports
                └── plugins/
                    ├── ui/
                    │   ├── tokyonight.lua  # Vivid, high-contrast dark theme overrides
                    │   └── lualine.lua     # Statusbar tracking active file encodings & LSP states
                    ├── coding/
                    │   ├── lsp.lua         # Modern Neovim native vim.lsp.config (No deprecations)
                    │   ├── blink.cmp       # Fast autocomplete with inline snippet previewers
                    │   ├── autopairs.lua   # Conflict-free tag & boundary closure automation
                    │   └── emmet.lua       # Classic expansion triggers (,,) & wrap tools
                    └── editor/
                        ├── telescope.lua   # Fuzzy searcher tracking active master branch hooks
                        ├── whichkey.lua    # Real-time visual shortcuts guide board
                        └── neotree.lua     # Workspace file navigation panel
```

---

## 🚀 Rapid Local Deployment

### 1. Prerequisites
Ensure your machine has the required system packages, syntax tree components, and styling icons installed:

```bash
# Arch Linux
sudo pacman -S git stow nodejs npm clang xclip

# Ubuntu / Debian
sudo apt update && sudo apt install git stow nodejs npm clang xclip
```

### 2. Clone and Link via GNU Stow
Clone your repository into your home directory and use Stow to generate system-compliant symlinks pointing back to your terminal configuration directories natively:

```bash
# Clone down your central directory repository
cd ~
git clone <your-github-repo-url> dotfiles

# Deploy the configuration pointers onto your home system paths
cd ~/dotfiles
stow -R nvim
```

### 3. Initialize & Install Plugins
Launch your editor. Your system will recognize the isolated settings, initialize the `lazy.nvim` engine framework, and automatically pull down your localized disk dependencies:

```bash
nvim
```
Once inside, sync the ecosystem entirely:
```text
:Lazy clean | Lazy sync
```

---

## 🔄 Cross-Machine Synchronization Loop

When moving between work stations, always commit updates upstream and cleanly pull down modifications to keep systems synchronized.

### On the Primary Machine (Push Changes):
```bash
cd ~/dotfiles
git add .
git commit -m "feat: customize element configuration layout parameters"
git push origin main
```

### On the Secondary Machine (Pull Changes):
```bash
cd ~/dotfiles
git pull origin main
stow -R nvim  # Forces Stow to refresh system symlink structures for newly added subfolders
```

---

## ⚡ Core Operational Workflows

This workspace maps key configurations explicitly to save time and streamline editing processes. Your `<leader>` is mapped directly to the **Spacebar**.

### 🔍 Find / Telescope (`<leader>f`)
*   `<leader>ff` — Fuzzy find files inside your active directory path.
*   `<leader>fg` — Live grep search for raw strings across file boundaries.
*   `<leader>fc` — Jump instantly into any configuration file using Telescope filtered directly to `~/.config/nvim/`.

### 🎛️ Dynamic Toggle Options (`<leader>t`)
Change editor behavior on the fly with instant toast notification confirmation flags:
*   `<leader>tw` — Toggle development deprecation warnings (Mute/Show).
*   `<leader>tn` — Toggle between Relative hybrid lines and fixed sequence lines.
*   `<leader>tl` — Toggle word wrapping boundaries (great for formatting markdown text).
*   `<leader>td` — Toggle inline LSP error diagnostic visibility out of view.

### 🌐 Web & HTML Production Essentials
*   `ul>li*4` followed by `, ,` — Instantly inflates raw text blocks into 4 structured list rows in Insert mode.
*   `Visual Highlight` followed by `sa` or `S` then `t` — Invokes `mini.surround` to wrap your selection in any custom tag or structure (e.g., typing `ul>li` wraps your text deep inside a list row block).

