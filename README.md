# 🌌 daniel's modular dotfiles

A minimal, high-performance, and deeply modularized configuration suite built for modern Neovim versions. Managed entirely using **GNU Stow** to synchronize a unified terminal environment across multiple machines.

---

## 📂 Repository Structure

The layout uses a highly granular architecture. By grouping plugins into `ui/`, `coding/`, and `editor/` subdirectories with automated recursive scanning (`recurse = true`), individual tools can be updated or debugged independently without impacting the core pipeline.

```text
~/.dotfiles/
├── .gitignore                # Safely excludes node_modules, cache, & lazy runtime paths
├── README.md                 # System setup documentation (this file)
└── nvim/                     # GNU Stow target package folder
    └── .config/
        └── nvim/
            ├── init.lua              # Ultra-minimal orchestrator (loads options -> keybinds -> lazy -> auto)
            └── lua/
                ├── config/
                │   ├── options.lua   # Global preferences (line numbers, wrapping layouts)
                │   ├── keybinds.lua  # General map keys & custom <leader>t Toggle group
                │   ├── lazy.lua      # lazy.nvim bootstrapper configured with automated recursion
                │   └── auto.lua      # Automated event loops (loaded last)
                └── plugins/
                    ├── ui/
                    │   ├── color.lua             # Tokyonight theme & neon aesthetic overrides
                    │   ├── indent-blankline.lua  # Vertical indentation scope guides
                    │   ├── lualine.lua           # Statusbar displaying file encoding & LSP states
                    │   └── neotree.lua           # Side-docked filesystem explorer panel
                    ├── coding/
                    │   ├── nvim-lspconfig.lua    # Native 0.12+ LSP setups & bottom split shortcuts
                    │   ├── blink.lua             # Fast completion engine & inline snippet previews
                    │   ├── emmet_vim.lua         # Classic HTML expansion triggers (,,)
                    │   ├── autopairs.lua         # Tag boundary closure automation
                    │   ├── treesitter.lua        # Syntax tree parsing & code coloring
                    │   ├── ts-autotag.lua        # Instant HTML tag closing/renaming
                    │   ├── ts-comments.lua       # Contextual comment strings
                    │   ├── conform.lua           # Auto-formatting (Prettier/Stylua)
                    │   ├── nvim-lint.lua         # Asynchronous linting framework
                    │   └── mason.lua             # Binary package downloader stub
                    ├── editor/
                    │   ├── telescope.lua         # Fuzzy finder tracking master branch compatibility
                    │   ├── which-key.lua         # Real-time visual shortcut menu
                    │   ├── vim-fugitive.lua      # Interactive inline Git wrapper
                    │   └── vim-gitgutter.lua     # Gutter markers tracking real-time line diffs
                    └── mini-nvim.lua             # Mini.ai and Mini.surround text-object extensions
```

---

## 🚀 Rapid Local Deployment

### 1. Prerequisites
Ensure your local machine has the required system packages, build tools, language compilers, and clipboard clipboards utilities installed matching your Linux distribution package manager:

```bash
# openSUSE (Tumbleweed / Leap)
sudo zypper refresh
sudo zypper install git-core stow nodejs npm gcc-c++ clang xclip

# Arch Linux
sudo pacman -S git stow nodejs npm clang xclip

# Ubuntu / Debian
sudo apt update && sudo apt install git stow nodejs npm clang xclip
```

### 2. Symlink via GNU Stow
Clone your repository into your home folder and deploy it. Stow will generate system-compliant symlinks pointing your host environment back to your central dotfiles repository paths natively:

```bash
# Clone down your personal dotfiles repository
cd ~
git clone https://github.com/dwwob/dotfiles ~/.dotfiles

# Deploy the configuration pointers onto your home system paths
cd ~/.dotfiles
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

When moving between workstations, always push updates upstream and cleanly pull down modifications to keep systems in perfect parity.

### On your Primary Machine (Push Changes):
```bash
cd ~/.dotfiles
git add .
git commit -m "feat: adjust text object selection layouts"
git push origin main
```

### On your Secondary Machine (Pull Changes):
```bash
cd ~/.dotfiles
git pull origin main
stow -R nvim  # Forces Stow to refresh system symlink structures for newly added modules
```

---

## ⚡ Core Operational Workflows

This workspace maps key configurations explicitly to maximize editing speed. Your `<leader>` key is mapped directly to the **Spacebar**.

### 🔍 Find & Navigate (`<leader>f`)
*   `<leader>ff` — Fuzzy find files inside your active directory path.
*   `<leader>fg` — Live grep search for raw text strings across file boundaries.
*   `<leader>fc` — Jump instantly into any configuration file using Telescope filtered directly to your Neovim files.
*   `<leader>e` — Toggle the Neo-tree sidebar to visually navigate folders.

### 🎛️ Dynamic Toggle Options (`<leader>t`)
Change editor behavior on the fly with immediate status bar toast notifications:
*   `<leader>tw` — Toggle development deprecation warnings (Mute/Show).
*   `<leader>tn` — Toggle between Relative hybrid lines and fixed sequence lines.
*   `<leader>tl` — Toggle word wrapping boundaries (ideal for long paragraphs).
*   `<leader>td` — Toggle inline LSP error diagnostic text visibility out of view.

### 💻 Native Code Definition Splits
*   `<leader>gpd` — Cuts open a horizontal split panel **at the very bottom** of your layout grid and navigates straight to the active item definition.
*   `<leader>gpr` — Opens a horizontal split panel at the bottom displaying all references to the item under your cursor.

### 🌐 HTML & Web Production Essentials
*   `ul>li*4` followed by `, ,` — Instantly inflates raw text abbreviations into 4 structured list rows in Insert mode.
*   `Visual Highlight` followed by `sa` or `S` then `t` — Invokes `mini.surround` to wrap your current text selection inside any custom tag layout structure (e.g., typing `ul>li` wraps your text inside a list item row).

