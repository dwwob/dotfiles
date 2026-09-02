# 🌌 daniel's modular dotfiles

A minimal, high-performance, and deeply modularized configuration suite built for modern Neovim versions (**v0.12+ / Nightly**). Managed entirely using **GNU Stow** to synchronize a unified terminal environment across multiple machines.

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

If you want to use this exact configuration on your own machine, make sure you are on neovim version 12+ then follow these deployment steps:

### 1. Install Prerequisites
Ensure your system has the required system packages, build tools, language compilers, and clipboard utilities installed matching your Linux distribution package manager:

```bash
# openSUSE (Tumbleweed / Leap)
sudo zypper refresh
sudo zypper install git-core stow nodejs npm gcc-c++ clang xclip

# Arch Linux
sudo pacman -y -S git stow nodejs npm clang xclip

# Ubuntu / Debian
sudo apt update && sudo apt install -y git stow nodejs npm clang xclip
```

### 2. Clone and Symlink via GNU Stow
Clone this repository directly into your home folder as a hidden directory (`.dotfiles`) and use Stow to generate system-compliant symlinks. This cleanly links your system's `~/.config/nvim` folder back to the repository:

```bash
# Clone the dotfiles repository
cd ~
git clone https://github.com/dwwob/dotfiles ~/.dotfiles

# Deploy the configuration pointers onto your home system paths via Stow
cd ~/.dotfiles
stow -R nvim
```

### 3. Initialize & Install Plugins
Launch Neovim. The system will automatically detect the isolated configurations, bootstrap the `lazy.nvim` engine framework, and download all required language servers and plugin dependencies onto your local machine:

```bash
nvim
```
Once inside the editor, fully synchronize the ecosystem:
```text
:Lazy clean | Lazy sync
```

---

## ⚡ Core Operational Workflows

This workspace maps key configurations explicitly to maximize editing speed. The `<leader>` key is mapped directly to the **Spacebar**.

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

