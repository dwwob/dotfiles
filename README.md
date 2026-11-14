🌌 Daniel's modular dotfiles
A minimal, high-performance, and deeply modularized configuration suite built explicitly for modern Neovim versions (v0.12+ / Nightly). Managed entirely using GNU Stow to synchronize a clean terminal development environment across multiple machines.

🖥️ System compatibility
[!IMPORTANT]
Platform notice: This entire configuration suite has been built and strictly tested exclusively on openSUSE Tumbleweed running the KDE Plasma desktop environment.
Special integrations — such as the background browser live-reloads automatically rolling up the Yakuake drop-down terminal via D-Bus controller channels (qdbus) — rely natively on openSUSE's toolchains and Plasma window manager mechanics. Running this layout on other distributions or different window managers may require adjusting the shell hooks inside toggleterm.lua.

📂 Repository structure
The layout utilizes a highly granular architecture. By grouping plugins into isolated subdirectories under nvim/.config/nvim/lua/plugins/, the core init.lua orchestrator scans and mounts configurations dynamically using a fast native filesystem loop, removing the need for manual file requirements.
~/.dotfiles/
├── .gitignore
├── README.md
└── nvim/
└── .config/
└── nvim/
├── init.lua
└── lua/
├── config/
│ ├── auto.lua
│ ├── filetypes.lua
│ ├── keybinds.lua
│ ├── lazy.lua
│ └── options.lua
└── plugins/
├── coding/
│ ├── blink-lib.lua
│ ├── blink.lua
│ ├── cobol_snippets.lua
│ ├── conform.lua
│ ├── emmet_vim.lua
│ ├── goto-preview.lua
│ ├── lsp_signature.lua
│ ├── mason.lua
│ ├── nvim-lint.lua
│ ├── nvim-lspconfig.lua
│ ├── treesitter.lua
│ └── ts-autopairs.lua
├── core/
│ ├── git.lua
│ └── toggleterm.lua
├── editor/
│ ├── inline.lua
│ ├── telescope.lua
│ ├── trouble.lua
│ ├── vim-fugitive.lua
│ └── which-key.lua
├── mini-nvim.lua
├── snacks.lua
├── ui/
│ ├── color.lua
│ ├── indent-blankline.lua
│ ├── lualine.lua
│ └── neotree.lua
└── ui.lua
[!WARNING]
Subdirectory rule: Do not name files init.lua inside any nested subdirectories (e.g., lua/plugins/ui/init.lua). If an init.lua exists inside a subdirectory, lazy.nvim will parse only that file and completely skip scanning adjacent modules in that folder.

🚀 Rapid local deployment

1. Install prerequisites
   Ensure your system has the required build tools, language compilers, global Node modules for live-servers, and clipboard utilities installed matching your Linux distribution package manager:

# openSUSE Tumbleweed (fully tested & supported environment)

sudo zypper refresh
sudo zypper install -y git-core stow nodejs npm gcc-c++ clang xclip wl-clipboard gnu-cobol
sudo npm install -g browser-sync

# Arch Linux (community port setup)

sudo pacman -y -S git stow nodejs npm clang xclip wl-clipboard gnucobol
sudo npm install -g browser-sync

# Ubuntu / Debian (community port setup)

sudo apt update && sudo apt install -y git stow nodejs npm clang xclip wl-clipboard open-cobol
sudo npm install -g browser-sync 2. Clone and symlink via GNU Stow
Clone this repository directly into your home folder as a hidden directory (.dotfiles) and use Stow to generate system-compliant symlinks. This cleanly links your system's ~/.config/nvim folder back to the repository:

# Clone the dotfiles repository

cd ~
git clone https://github.com/dwwob/dotfiles ~/.dotfiles

# Deploy the configuration pointers onto your home system paths via Stow

cd ~/.dotfiles
stow -R nvim 3. Initialize and install plugins
Launch Neovim. The system will automatically detect the isolated configurations, bootstrap the lazy.nvim engine framework, and download all required language servers and plugin dependencies onto your local machine:
nvim
Once inside the editor, fully synchronize the ecosystem:
:Lazy clean | Lazy sync

⚡ Core operational workflows
This workspace maps key configurations explicitly to maximize editing speed. The <leader> key is mapped directly to the Spacebar.
🔍 Find and navigate (<leader>f)
<leader>ff — Fuzzy find files inside your active directory path.
<leader>fg — Live grep search for raw text strings across file boundaries.
<leader>fc — Jump instantly into any configuration file using Telescope filtered directly to your Neovim files.
<leader>fd — Search the Dotfiles Repository directly from anywhere by following Stow symlink pointers.
<leader>e — Toggle the Neo-tree sidebar to visually navigate folders.
🎛️ Dynamic toggle and terminal options (<leader>t)
Change editor behavior on the fly with immediate status bar notifications or toggle integrated terminal shells:
Keystroke
Action description
UI / status indication
<leader>tw
Toggle development deprecation warnings
⚠️ Warn log / 🔇 Muted banner
<leader>tn
Toggle line numbers (relative / absolute)
🔢 Relative ON / ABSOLUTE banner
<leader>ts
Toggle visual spell check highlights
🔤 Interactive status check icon
<leader>tl
Toggle editor line wrap options
↔️ Wrap ON / OFF notification
<leader>tx
Toggle project-wide diagnostics split view
🔍 Global Trouble error tray panel
<leader>td
Toggle buffer-only diagnostic error list
🩺 Active file buffer Trouble view
<leader>tq
Toggle Quickfix layout manager window
🛠️ Project tracking Quickfix tray
<leader>tc
Compile and run current script
🔨 Compiles C/C++, Python or COBOL on-demand
<leader>tg
Toggle Lazygit application dashboard
📊 Fullscreen transient floating panel
<leader>th
Open horizontal terminal split
📥 Bottom layout split panel
<leader>tv
Open vertical terminal split
➡️ Right layout split panel
<leader>tf
Open floating shell window
🎚️ Centered curved floating interface
<leader>tp
Start realtime HTML viewer
🌐 Launches browser-sync + Yakuake roll-up
<leader>tP
Stop realtime HTML viewer
🛑 Kills background node network tasks

🔨 Automated code compilers and standards (BufWritePost)
Writing changes inside an active code buffer automatically spins up background compiler routines on file save via ToggleTerm. If compilation succeeds, a clean floating viewport displays your program's logs and results seamlessly.
🚀 Dynamic C/C++ standards detection
You can target bleeding-edge compiler architectures dynamically. By placing a specialized flag on line 1 of your C/C++ source code, the auto-compiler parses the string literal natively, injects the proper compiler arguments, and bypasses LSP blocking traps:
// std=c23 or // std=gnu23 — Forces gcc to compile using the modern C23 standard (enabling nullptr, binary literals, etc.).
// std=c++20 — Forces g++ to compile using C++20.
// std=c++23 — Forces g++ to compile using C++23.
📝 Supported language automation pipelines
Python (_.py): Runs the script natively via python3 after automated isort and black formatting passes.
COBOL (_.cob / _.cbl): Triggers custom keyword uppercase normalization rules via sed, formats spacing definitions, and runs compilation via cobc -x.
Shell (_.sh): Grants local executable flags (chmod +x) and runs the script natively.

🌐 Editor utilities and whitelisting
🔤 Global spelling whitelist (<leader>sa)
To add a word under your cursor to your global dictionary so it permanently stops throwing red squiggly spelling annotations, press <leader>sa in Normal mode. This instantly writes the raw text to ~/.cspell.json and updates active buffer diagnostics dynamically.
🌈 Rainbow indentation and COBOL formatting

🎁 Bonus
If you are diabetic, you can type mealplan in your shell for a sample 3-day meal plan and glucose tracker. The plan will let you enter your info multiple times a day and keep track, so you don't have to make a new one if you need to add to it later in the day. Then, when it is the next day, it will start a new tracking when you invoke mealplan for that day. Each of your daily logs will be in your Documents folder by date. This does not send any data or trackers — it is all kept in the Documents folder. Make sure you source your bashrc before it will work. If your bashrc didn't update to the new one, then just copy and paste from that section of my bash aliases file to your bashrc, or wherever you keep your aliases, and then save and source bashrc. Then just type mealplan in your shell. (Only tested on bash.)
