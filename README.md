# 🌌 daniel's modular dotfiles

A minimal, high-performance, and deeply modularized configuration suite built explicitly for modern Neovim versions (**v0.12+ / Nightly**). Managed entirely using **GNU Stow** to synchronize a clean terminal development environment across multiple machines.

---

## 🖥️ System Compatibility

> [!IMPORTANT]
> **Platform Notice:** This entire configuration suite has been built and strictly tested **exclusively on openSUSE Tumbleweed** running the **KDE Plasma** desktop environment.
> Special integrations—such as the background browser live-reloads automatically rolling up the **Yakuake drop-down terminal** via D-Bus controller channels (`qdbus`)—rely natively on openSUSE's toolchains and Plasma window manager mechanics. Running this layout on other distributions or different window managers may require adjusting the shell hooks inside `toggleterm.lua`.

---

## 📂 Repository Structure

The layout utilizes a highly granular architecture. By grouping plugins into isolated subdirectories under `nvim/.config/nvim/lua/plugins/`, the core `init.lua` orchestrator scans and mounts configurations dynamically using a fast native filesystem loop, removing the need for manual file requirements.

```text
~/.dotfiles/
├── .gitignore                # Safely excludes node_modules, cache, & lazy runtime paths
├── README.md                 # System setup documentation (this file)
└── nvim/                     # GNU Stow target package folder
    └── .config/
        └── nvim/
            ├── init.lua              # Orchestrator (Extended timeouts & dynamic folder scanning)
            └── lua/
                ├── config/
                │   ├── options.lua   # Global preferences (line numbers, wrapping layouts)
                │   ├── keybinds.lua  # General keymaps, native bracket matching, & cspell additions
                │   └── auto.lua      # Async save compilers (C23, C++23, Python, COBOL) & LSP toasts
                └── plugins/
                    ├── coding/               # Language Parsing, LSP, & Completion Engine
                    │   ├── blink.lua         # Fast completion engine & snippet engine definitions
                    │   ├── cobol_snippets.lua# Dedicated division templates for mainframes
                    │   ├── conform.lua       # Auto-formatting framework (Prettier, clang-format, stylua)
                    │   ├── emmet_vim.lua     # Classic HTML expansion triggers (,,)
                    │   ├── goto-preview.lua  # Floating definition preview viewports
                    │   ├── lsp_signature.lua # Live function argument window guides while typing
                    │   ├── mason.lua         # Binary language server downloader manager
                    │   ├── nvim-lint.lua     # Asynchronous linting framework
                    │   └── nvim-lspconfig.lua# Core native LSP configuration client bindings (0.12+ API)
                    ├── core/                 # Global System Utilities
                    │   └── toggleterm.lua    # Integrated Lazygit, floating shells, & Realtime HTML Preview
                    ├── editor/               # Project Navigation & Key Guides
                    │   ├── telescope.lua     # Stow-aware fuzzy search module (tracks master branch)
                    │   ├── trouble.nvim      # Filterable split panel diagnostic error aggregator
                    │   ├── vim-fugitive.lua  # Interactive inline Git wrapper
                    │   └── which-key.lua     # v3 Option menu navigation dashboard panel
                    └── ui/                   # Interface Aesthetics & Component Themes
                        ├── color.lua         # Tokyonight theme & aesthetic parameters
                        ├── indent-blankline.lua # Dynamic rainbow indent guide vectors (v3 IBL)
                        └── lualine.lua       # Statusline tracking active buffer 0.12+ LSP clients
```

> [!WARNING]
> **Subdirectory Rule:** Do not name files `init.lua` inside any nested subdirectories (e.g., `lua/plugins/ui/init.lua`). If an `init.lua` exists inside a subdirectory, `lazy.nvim` will parse _only_ that file and completely skip scanning adjacent modules in that folder.

---

## 🚀 Rapid Local Deployment

### 1. Install Prerequisites

Ensure your system has the required build tools, language compilers, global Node modules for live-servers, and clipboard utilities installed matching your Linux distribution package manager:

```bash
# openSUSE Tumbleweed (Fully Tested & Supported Environment)
sudo zypper refresh
sudo zypper install -y git-core stow nodejs npm gcc-c++ clang xclip wl-clipboard gnu-cobol
sudo npm install -g browser-sync

# Arch Linux (Community Port Setup)
sudo pacman -y -S git stow nodejs npm clang xclip wl-clipboard gnucobol
sudo npm install -g browser-sync

# Ubuntu / Debian (Community Port Setup)
sudo apt update && sudo apt install -y git stow nodejs npm clang xclip wl-clipboard open-cobol
sudo npm install -g browser-sync
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

- `<leader>ff` — Fuzzy find files inside your active directory path.
- `<leader>fg` — Live grep search for raw text strings across file boundaries.
- `<leader>fc` — Jump instantly into any configuration file using Telescope filtered directly to your Neovim files.
- `<leader>fd` — Search Dotfiles Repository directly from anywhere by following Stow symlink pointers.
- `<leader>e` — Toggle the Neo-tree sidebar to visually navigate folders.

### 🎛️ Dynamic Toggle & Terminal Options (`<leader>t`)

Change editor behavior on the fly with immediate status bar notifications or toggle integrated terminal shells:

| Keystroke    | Action Description                         | UI/Status Indication                         |
| :----------- | :----------------------------------------- | :------------------------------------------- |
| `<leader>tw` | Toggle development deprecation warnings    | ⚠️ Warn Log / 🔇 Muted Banner                |
| `<leader>tn` | Toggle Line Numbers (Relative/Absolute)    | 🔢 Relative ON / ABSOLUTE Banner             |
| `<leader>ts` | Toggle Visual Spell Check Highlights       | 🔤 Interactive Status Check Icon             |
| `<leader>tl` | Toggle Editor Line Wrap Options            | ↔️ Wrap ON / OFF Notification                |
| `<leader>tx` | Toggle project-wide diagnostics split view | 🔍 Global Trouble Error Tray panel           |
| `<leader>td` | Toggle buffer-only diagnostic error list   | 🩺 Active file buffer Trouble view           |
| `<leader>tq` | Toggle Quickfix layout manager window      | 🛠️ Project tracking Quickfix tray            |
| `<leader>tc` | **Compile & Run Current Script**           | 🔨 Compiles C/C++, Python or COBOL on-demand |
| `<leader>tg` | Toggle Lazygit Application Dashboard       | 📊 Fullscreen transient floating panel       |
| `<leader>th` | Open Horizontal Terminal Split             | 📥 Bottom layout split panel                 |
| `<leader>tv` | Open Vertical Terminal Split               | ➡️ Right layout split panel                  |
| `<leader>tf` | Open Floating Shell Window                 | 🎚️ Centered curved floating interface        |
| `<leader>tp` | **Start Realtime HTML Viewer**             | 🌐 Launches browser-sync + Yakuake roll-up   |
| `<leader>tP` | **Stop Realtime HTML Viewer**              | 🛑 Kills background node network tasks       |

---

## 🔨 Automated Code Compilers & Standards (`BufWritePost`)

Writing changes inside an active code buffer automatically spins up background compiler routines on file save via ToggleTerm. If compilation succeeds, a clean floating viewport displays your program's logs and results seamlessly.

### 🚀 Dynamic C/C++ Standards Detection

You can target bleeding-edge compiler architectures dynamically. By placing a specialized flag on **Line 1** of your C/C++ source code, the auto-compiler parses the string literal natively, injects the proper compiler arguments, and bypasses LSP blocking traps:

- `// std=c23` or `// std=gnu23` — Forces `gcc` to compile using the modern **C23 standard** (enabling `nullptr`, binary literals, etc.).
- `// std=c++20` — Forces `g++` to compile using **C++20**.
- `// std=c++23` — Forces `g++` to compile using **C++23**.

### 📝 Supported Language Automation Pipelines

- **Python (`*.py`):** Runs the script natively via `python3` after automated `isort` and `black` formatting passes.
- **COBOL (`*.cob` / `*.cbl`):** Triggers custom keyword uppercase normalization rules via `sed`, formats spacing definitions, and runs compilation via `cobc -x`.
- **Shell (`*.sh`):** Grants local executable flags (`chmod +x`) and runs the script natively.

---

## 🌐 Editor Utilities & Whitelisting

### 🔤 Global Spelling Whitelist (`<leader>sa`)

To add a word under your cursor to your global dictionary so it permanently stops throwing red squiggly spelling annotations, press **`<leader>sa`** in Normal mode. This instantly writes the raw text to `~/.cspell.json` and updates active buffer diagnostics dynamically.

### 🌈 Rainbow Indentation & COBOL Formatting
