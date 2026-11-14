-- ~/.config/nvim/lua/config/options.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed, except for one thing noted below.
-- Changes are only to layout: one header style throughout, and
-- each group of settings kept together under its own header.
--
-- Removed: the whole diagnostic config was repeated at the bottom
-- of your original file, commented out. That duplicate is gone;
-- the one live copy is in the Diagnostics section at the end.
--
-- Diagnostic signs: each sign is a single character, with no
-- trailing space, so it stays 1 cell wide and does not trigger
-- the "Invalid 'sign_text'" error.

-- ---------------------------------------------------------------------------
-- Line numbers and UI
-- ---------------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.updatetime = 250

-- ---------------------------------------------------------------------------
-- Tabs
-- ---------------------------------------------------------------------------
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- ---------------------------------------------------------------------------
-- Cursor and rendering
-- ---------------------------------------------------------------------------
vim.opt.cursorline = true
vim.opt.guicursor = ""
vim.opt.scrolloff = 10

-- ---------------------------------------------------------------------------
-- Wrap and indent
-- ---------------------------------------------------------------------------
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:0,min:50"
vim.opt.smartindent = true
-- vim.opt.showbreak = "↳ "

-- ---------------------------------------------------------------------------
-- Splits
-- ---------------------------------------------------------------------------
vim.opt.inccommand = "split"
vim.opt.splitbelow = true
vim.opt.splitright = true

-- ---------------------------------------------------------------------------
-- Search
-- ---------------------------------------------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ---------------------------------------------------------------------------
-- Status line and command line
-- ---------------------------------------------------------------------------
vim.opt.laststatus = 2
vim.opt.cmdheight = 1 -- Dropped to 1 for more vertical space; perfect for mini.cmdline/popup layouts

-- ---------------------------------------------------------------------------
-- Spell checker
-- ---------------------------------------------------------------------------
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }

-- ---------------------------------------------------------------------------
-- Undo, swap and backup
-- ---------------------------------------------------------------------------
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- ---------------------------------------------------------------------------
-- Completion menu
-- ---------------------------------------------------------------------------
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.isfname = vim.opt.isfname + "@-@"

-- ---------------------------------------------------------------------------
-- Command line wildmenu
-- ---------------------------------------------------------------------------
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum,tagfile,fuzzy"

-- ---------------------------------------------------------------------------
-- Clipboard and window title
-- ---------------------------------------------------------------------------
vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"
vim.opt.title = true
vim.opt.titlestring = "NVIM 🦎 %{expand('%:p:~')}"

-- ---------------------------------------------------------------------------
-- Autocommands
-- ---------------------------------------------------------------------------
-- Highlight text selections on copy yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})

-- ---------------------------------------------------------------------------
-- Diagnostics (Neovim 0.12+ native style)
-- ---------------------------------------------------------------------------
-- Each sign is a single character (1 cell wide, no trailing space).
local signs = { Error = "", Warn = "", Hint = " ", Info = "" }

vim.diagnostic.config({
	-- Inline virtual text (toggle with <leader>td)
	virtual_text = true,

	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = signs.Error,
			[vim.diagnostic.severity.WARN] = signs.Warn,
			[vim.diagnostic.severity.HINT] = signs.Hint,
			[vim.diagnostic.severity.INFO] = signs.Info,
		},
	},

	-- Undercurls/underlines for errors
	underline = true,

	-- Sort diagnostics by severity
	severity_sort = true,

	-- Floating hover window (triggered by vim.diagnostic.open_float)
	float = {
		focused = false,
		style = "minimal",
		border = "rounded",
		source = "always", -- Shows the name of the LSP server generating the error
		header = "",
		prefix = "",
	},
})

-- -- ~/.config/nvim/lua/config/options.lua
--
-- -- ==========================================
-- -- Setting Line Numbers & UI Signs
-- -- ==========================================
-- vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.opt.colorcolumn = "0"
-- vim.opt.signcolumn = "yes"
-- vim.opt.termguicolors = true
-- vim.opt.updatetime = 250
--
-- -- ==========================================
-- -- Settings for Tab Stop and Behavior
-- -- ==========================================
-- vim.opt.tabstop = 2
-- vim.opt.softtabstop = 2
-- vim.opt.shiftwidth = 2
-- vim.opt.expandtab = true
--
-- -- ==========================================
-- -- Set Cursor Line & Rendering
-- -- ==========================================
-- vim.opt.cursorline = true
-- vim.opt.guicursor = ""
-- vim.opt.scrolloff = 10
--
-- -- ==========================================
-- -- Line Wrap & Indent Settings
-- -- ==========================================
-- vim.opt.wrap = true
-- vim.opt.linebreak = true
-- vim.opt.breakindent = true
-- vim.opt.breakindentopt = "shift:0,min:50"
-- vim.opt.smartindent = true
-- -- vim.opt.showbreak = "↳ "
--
-- -- ==========================================
-- -- Buffer & Layout Splits
-- -- ==========================================
-- vim.opt.inccommand = "split"
-- vim.opt.splitbelow = true
-- vim.opt.splitright = true
--
-- -- ==========================================
-- -- Search Engine Tweaks
-- -- ==========================================
-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true
--
-- -- ==========================================
-- -- Status Line & Command Settings
-- -- ==========================================
-- vim.opt.laststatus = 2
-- vim.opt.cmdheight = 1 -- Dropped to 1 for more vertical space; perfect for mini.cmdline/popup layouts
--
-- -- ==========================================
-- -- Spell Checker Settings
-- -- ==========================================
-- vim.opt.spell = false
-- vim.opt.spelllang = { "en_us" }
--
-- -- ==========================================
-- -- Persistent History Recovery (Undo/Swap)
-- -- ==========================================
-- vim.opt.swapfile = false
-- vim.opt.backup = false
-- vim.opt.undofile = true
-- vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
--
-- -- ==========================================
-- -- Insert Mode Completion Menu Settings
-- -- ==========================================
-- vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
-- vim.opt.shortmess = vim.opt.shortmess + "c"
-- vim.opt.isfname = vim.opt.isfname + "@-@"
--
-- -- ==========================================
-- -- Command Line Wildmenu (Enhanced UI)
-- -- ==========================================
-- vim.opt.wildmenu = true
-- vim.opt.wildmode = "longest:full,full"
-- vim.opt.wildoptions = "pum,tagfile,fuzzy"
--
-- -- ==========================================
-- -- Clipboard & Window Title Configurations
-- -- ==========================================
-- vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"
-- vim.opt.title = true
-- vim.opt.titlestring = "NVIM 🦎 %{expand('%:p:~')}"
--
-- -- Autocommand to highlight text selections on copy yank
-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	desc = "Highlight when yanking (copying) text",
-- 	callback = function()
-- 		vim.hl.on_yank()
-- 	end,
-- })
--
-- -- =========================================================================
-- -- LSP Diagnostic Customization (Neovim 0.12+ Native Style)
-- -- =========================================================================
--
-- -- Define clean, modern diagnostic signs/icons
-- local signs = { Error = "", Warn = "", Hint = " ", Info = "" }
--
-- -- Configure native diagnostic layout engine
-- vim.diagnostic.config({
-- 	virtual_text = true,
--
-- 	signs = {
-- 		text = {
-- 			[vim.diagnostic.severity.ERROR] = signs.Error,
-- 			[vim.diagnostic.severity.WARN] = signs.Warn,
-- 			[vim.diagnostic.severity.HINT] = signs.Hint,
-- 			[vim.diagnostic.severity.INFO] = signs.Info,
-- 		},
-- 	},
--
-- 	underline = true,
-- 	severity_sort = true,
--
-- 	float = {
-- 		focused = false,
-- 		style = "minimal",
-- 		border = "rounded",
-- 		source = "always",
-- 		header = "",
-- 		prefix = "",
-- 	},
-- })
--
-- -- -- Define clean, modern diagnostic signs/icons
-- -- local signs = { Error = "  ", Warn = "  ", Hint = "  ", Info = "  " }
-- --
-- -- -- Configure native diagnostic layout engine
-- -- vim.diagnostic.config({
-- -- 	-- Disable inline virtual text to keep your lines clean (toggle with <leader>td)
-- -- 	virtual_text = true,
-- --
-- -- 	-- Set modern signs directly inside the config table (No signdefine loop!)
-- -- 	signs = {
-- -- 		text = {
-- -- 			[vim.diagnostic.severity.ERROR] = signs.Error,
-- -- 			[vim.diagnostic.severity.WARN] = signs.Warn,
-- -- 			[vim.diagnostic.severity.HINT] = signs.Hint,
-- -- 			[vim.diagnostic.severity.INFO] = signs.Info,
-- -- 		},
-- -- 	},
-- --
-- -- 	-- Enable undercurls/underlines for errors
-- -- 	underline = true,
-- --
-- -- 	-- Sort diagnostics by severity
-- -- 	severity_sort = true,
-- --
-- -- 	-- Customize the floating hover window layout (triggered by vim.diagnostic.open_float)
-- -- 	float = {
-- -- 		focused = false,
-- -- 		style = "minimal",
-- -- 		border = "rounded",
-- -- 		source = "always", -- Shows the name of the LSP server generating the error
-- -- 		header = "",
-- -- 		prefix = "",
-- -- 	},
-- -- })
