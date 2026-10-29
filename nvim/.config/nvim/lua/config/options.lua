-- ~/.config/nvim/lua/config/options.lua

-- ==========================================
-- Setting Line Numbers & UI Signs
-- ==========================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.updatetime = 250

-- ==========================================
-- Settings for Tab Stop and Behavior
-- ==========================================
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- ==========================================
-- Set Cursor Line & Rendering
-- ==========================================
vim.opt.cursorline = true
vim.opt.guicursor = ""
vim.opt.scrolloff = 10

-- ==========================================
-- Line Wrap & Indent Settings
-- ==========================================
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:0,min:50"
vim.opt.smartindent = true
-- vim.opt.showbreak = "↳ "

-- ==========================================
-- Buffer & Layout Splits
-- ==========================================
vim.opt.inccommand = "split"
vim.opt.splitbelow = true
vim.opt.splitright = true

-- ==========================================
-- Search Engine Tweaks
-- ==========================================
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ==========================================
-- Status Line & Command Settings
-- ==========================================
vim.opt.laststatus = 2
vim.opt.cmdheight = 1 -- Dropped to 1 for more vertical space; perfect for mini.cmdline/popup layouts

-- ==========================================
-- Spell Checker Settings
-- ==========================================
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }

-- ==========================================
-- Persistent History Recovery (Undo/Swap)
-- ==========================================
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- ==========================================
-- Insert Mode Completion Menu Settings
-- ==========================================
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.isfname = vim.opt.isfname + "@-@"

-- ==========================================
-- Command Line Wildmenu (Enhanced UI)
-- ==========================================
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum,tagfile,fuzzy"

-- ==========================================
-- Clipboard & Window Title Configurations
-- ==========================================
vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"
vim.opt.title = true
vim.opt.titlestring = "NVIM 🦎 %{expand('%:p:~')}"

-- Autocommand to highlight text selections on copy yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.hl.on_yank()
  end,
})


-- =========================================================================
-- LSP Diagnostic Customization (Neovim 0.12+ Native Style)
-- =========================================================================

-- Define clean, modern diagnostic signs/icons
local signs = { Error = "  ", Warn = "  ", Hint = "  ", Info = "  " }

-- Configure native diagnostic layout engine
vim.diagnostic.config({
  -- Disable inline virtual text to keep your lines clean (toggle with <leader>td)
  virtual_text = false,

  -- Set modern signs directly inside the config table (No signdefine loop!)
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN]  = signs.Warn,
      [vim.diagnostic.severity.HINT]  = signs.Hint,
      [vim.diagnostic.severity.INFO]  = signs.Info,
    },
  },

  -- Enable undercurls/underlines for errors
  underline = true,

  -- Sort diagnostics by severity
  severity_sort = true,

  -- Customize the floating hover window layout (triggered by vim.diagnostic.open_float)
  float = {
    focused = false,
    style = "minimal",
    border = "rounded",
    source = "always", -- Shows the name of the LSP server generating the error
    header = "",
    prefix = "",
  },
})
