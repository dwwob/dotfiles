# 🌌 daniel's modular dotfiles

A minimal, high-performance, and deeply modularized configuration suite built for modern Neovim versions (**v0.12+ / Nightly**). Managed entirely using **GNU Stow** to synchronize a unified terminal environment across multiple machines [Mon, September 07, 2026 @ 05:11 PM].

---

## 📂 Repository Structure

The layout uses a highly granular architecture. By grouping plugins into isolated subdirectories under `nvim/.config/nvim/lua/plugins/`, your core `init.lua` orchestrator scans and mounts options dynamically using a fast native filesystem loop, removing the need for manual file requirements [Mon, September 07, 2026 @ 05:11 PM].

```text
~/.dotfiles/
├── .gitignore                # Safely excludes node_modules, cache, & lazy runtime paths
├── README.md                 # System setup documentation (this file)
└── nvim/                     # GNU Stow target package folder
    └── .config/
        └── nvim/
            ├── init.lua              # Orchestrator (Extended Git timeouts & dynamic folder scanning)
            └── lua/
                ├── config/
                │   ├── options.lua   # Global preferences (line numbers, wrapping layouts)
                │   ├── keybinds.lua  # General map keys & custom <leader>t Toggle group
                │   └── auto.lua      # Async save compilers (C/C++, Python, COBOL) & event loops
                └── plugins/
                    ├── mini-nvim.lua         # Mini text-object and utility extensions fallback
                    ├── coding/               # Language Parsing, LSP, & Completion Engine
                    │   ├── autoclose.lua     # Clean bracket pair insertions
                    │   ├── autopairs.lua     # Tag boundary closure automation
                    │   ├── blink.lua         # Fast completion engine & inline snippet previews
                    │   ├── conform.lua       # Auto-formatting framework (Prettier/Stylua)
                    │   ├── emmet_vim.lua     # Classic HTML expansion triggers (,,)
                    │   ├── goto-preview.lua  # Floating definition preview viewports
                    │   ├── lsp_signature.lua # Live function argument window guides while typing
                    │   ├── mason.lua         # Binary language server downloader manager
                    │   ├── nvim-lint.lua     # Asynchronous linting framework
                    │   ├── nvim-lspconfig.lua# Core native LSP configuration client bindings
                    │   ├── treesitter.lua    # Syntax tree parsing & code coloring
                    │   ├── ts-autotag.lua    # Instant HTML tag closing and renaming
                    │   └── ts-comments.lua   # Contextual comment string matching
                    ├── core/                 # Global System Utilities
                    │   └── toggleterm.lua    # Integrated Lazygit, floating shells, & Realtime HTML Preview
                    ├── editor/               # Project Navigation, Key Guides, & Diagnostics
                    │   ├── telescope.lua     # Stow-aware fuzzy search module (tracks master branch)
                    │   ├── trouble.nvim      # Filterable split panel diagnostic & error aggregator
                    │   ├── vim-fugitive.lua  # Interactive inline Git wrapper
                    │   ├── vim-gitgutter.lua # Gutter markers tracking real-time line diffs
                    │   └── which-key.lua     # v3 Option menu navigation dashboard panel
                    └── ui/                   # Interface Aesthetics & Component Themes
                        ├── color.lua         # Tokyonight theme & aesthetic parameters
                        ├── indent-blankline.lua # Context scope indentation guide vectors (ibl)
                        └── lualine.lua       # Global statusline tracking active buffer LSP states
```

> [!WARNING]
> **Subdirectory Rule:** Do not name files `init.lua` inside any nested subdirectories (e.g., `lua/plugins/ui/init.lua`). If an `init.lua` exists inside a subdirectory, `lazy.nvim` will parse *only* that file and completely skip scanning adjacent modules in that folder [Mon, September 07, 2026 @ 05:11 PM].

---

## 🚀 Rapid Local Deployment

If you want to use this exact configuration on your own machine, make sure you are on neovim version 12+ then follow these deployment steps [Mon, September 07, 2026 @ 05:11 PM]:

### 1. Install Prerequisites
Ensure your system has the required system packages, build tools, language compilers, and clipboard utilities installed matching your Linux distribution package manager [Mon, September 07, 2026 @ 05:11 PM]:

```bash
# openSUSE (Tumbleweed / Leap)
sudo zypper refresh
sudo zypper install git-core stow nodejs npm gcc-c++ clang xclip wl-clipboard

# Arch Linux
sudo pacman -y -S git stow nodejs npm clang xclip wl-clipboard

# Ubuntu / Debian
sudo apt update && sudo apt install -y git stow nodejs npm clang xclip wl-clipboard
```

### 2. Clone and Symlink via GNU Stow
Clone this repository directly into your home folder as a hidden directory (`.dotfiles`) and use Stow to generate system-compliant symlinks [Mon, September 07, 2026 @ 05:11 PM]. This cleanly links your system's `~/.config/nvim` folder back to the repository [Mon, September 07, 2026 @ 05:11 PM]:

```bash
# Clone the dotfiles repository
cd ~
git clone https://github.com ~/.dotfiles

# Deploy the configuration pointers onto your home system paths via Stow
cd ~/.dotfiles
stow -R nvim
```

### 3. Initialize & Install Plugins
Launch Neovim [Mon, September 07, 2026 @ 05:11 PM]. The system will automatically detect the isolated configurations, bootstrap the `lazy.nvim` engine framework, and download all required language servers and plugin dependencies onto your local machine [Mon, September 07, 2026 @ 05:11 PM]:

```bash
nvim
```

Once inside the editor, fully synchronize the ecosystem [Mon, September 07, 2026 @ 05:11 PM]:
```text
:Lazy clean | Lazy sync
```

---

## ⚡ Core Operational Workflows

This workspace maps key configurations explicitly to maximize editing speed. The `<leader>` key is mapped directly to the **Spacebar** [Mon, September 07, 2026 @ 05:11 PM].

### 🔍 Find & Navigate (`<leader>f`)

*   `<leader>ff` — Fuzzy find files inside your active directory path [Mon, September 07, 2026 @ 05:11 PM].
*   `<leader>fg` — Live grep search for raw text strings across file boundaries [Mon, September 07, 2026 @ 05:11 PM].
*   `<leader>fc` — Jump instantly into any configuration file using Telescope filtered directly to your Neovim files [Mon, September 07, 2026 @ 05:11 PM].
*   `<leader>fd` — Search Dotfiles Repository directly from anywhere by following Stow symlink pointers [Mon, September 07, 2026 @ 05:11 PM].
*   `<leader>e` — Toggle the Neo-tree sidebar to visually navigate folders [Mon, September 07, 2026 @ 05:11 PM].

### 🎛️ Dynamic Toggle & Terminal Options (`<leader>t`)

Change editor behavior on the fly with immediate status bar notifications or toggle integrated terminal shells [Mon, September 07, 2026 @ 05:11 PM]:

| Keystroke | Action Description | UI/Status Indication |
| :--- | :--- | :--- |
| `<leader>tw` | Toggle development deprecation warnings | ⚠️ Warn Log / 🔇 Muted Banner |
| `<leader>tn` | Toggle Line Numbers (Relative/Absolute) | 🔢 Relative ON / ABSOLUTE Banner |
| `<leader>ts` | Toggle Visual Spell Check Highlights | 🔤 Interactive Status Check Icon |
| `<leader>tl` | Toggle Editor Line Wrap Options | ↔️ Wrap ON / OFF Notification |
| `<leader>tx` | Toggle project-wide diagnostics split view | 🔍 Global Trouble Error Tray panel |
| `<leader>td` | Toggle buffer-only diagnostic error list | 🩺 Active file buffer Trouble view |
| `<leader>tq` | Toggle Quickfix layout manager window | 🛠️ Project tracking Quickfix tray |
| `<leader>tc` | Toggle Floating Terminal Command Launcher | 🚀 Search and invoke commands |
| `<leader>tg` | Toggle Lazygit Application Dashboard | 📊 Fullscreen transient floating panel |
| `<leader>th` | Open Horizontal Terminal Split | 📥 Bottom layout split panel |
| `<leader>tv` | Open Vertical Terminal Split | ➡️ Right layout split panel |
| `<leader>tf` | Open Floating Shell Window | 🎚️ Centered curved floating interface |
| `<leader>tp` | **Start Realtime HTML Viewer** | 🌐 Launches browser-sync server |
| `<leader>tP` | **Stop Realtime HTML Viewer** | 🛑 Kills background node network tasks |

### 🔨 Automated Code Compilers (`BufWritePost`)

Writing changes inside an active code buffer with zero syntax errors automatically spins up background compiler routines on file save. If compilation succeeds, a clean floating viewport displays your program's logs and results seamlessly:

*   **Python (`*.py`):** Runs the script natively via `python3`.
*   **C (`*.c`):** Automatically invokes `gcc`, compiles code to matching filenames, and launches the execution layer.
*   **C++ (`*.cpp` / `*.cc`):** Invokes `g++`, compiles the code tree, and triggers the output binary window layer.
*   **COBOL (`*.cob` / `*.cbl`):** Invokes the openSUSE COBOL compiler (`cobc -x`), compiles records, and executes the output binary.
*   **Shell (`*.sh`):** Grants local executable flags (`chmod +x`) and runs the script natively.

### 🌐 HTML & Web Production Essentials

*   `ul>li*4` followed by `, ,` — Instantly inflates raw text abbreviations into 4 structured list rows in Insert mode [Mon, September 07, 2026 @ 05:11 PM].
*   `Visual Highlight` followed by `sa` or `S` then `t` — Invokes `mini.surround` to wrap your current text selection inside custom tag layouts [Mon, September 07, 2026 @ 05:11 PM].

