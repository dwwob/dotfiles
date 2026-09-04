-- ~/.config/nvim/lua/config/options.lua
--
-- =========================================
-- set file encoding to utf-8
-- =========================================
vim.opt.fileencoding = "utf-8"
--
-- =========================================
-- setting line numbers options
-- =========================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"
--
-- ==========================================
-- settings for tab stop and behavior
-- ==========================================
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
--
-- ============================================
-- set cursor line settings
-- ============================================
vim.opt.cursorline = true
vim.opt.guicursor = ""
--
-- ============================================
-- line wrap settings
-- ============================================
vim.opt.wrap = true
vim.opt.linebreak = true
-- vim.opt.showbreak = "↳ "
--
-- =============================================
-- line indent settings
-- =============================================
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:0,min:40"
vim.opt.smartindent = true
--
-- ==============================================
-- buffer window settings
-- ==============================================
vim.opt.inccommand = "split"
vim.opt.splitbelow = true
vim.opt.splitright = true
--
-- ==============================================
-- search settings
-- ==============================================
vim.opt.ignorecase = true
vim.opt.smartcase = true
--
-- ==============================================
-- status line settings
-- ==============================================
vim.opt.laststatus = 2
vim.opt.cmdheight = 2
--
-- ==============================================
-- spell checker settings
-- ==============================================
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
--
-- ==============================================
-- undo file settings
-- ==============================================
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true
--
-- ==============================================
-- better completion menu
-- ===============================================
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.shortmess:append("c")
vim.opt.isfname:append("@-@")
--
-- ================================================
-- number of lines below or above the edges of the screen before the cursor stays
-- ================================================
vim.opt.scrolloff = 10
--
-- ================================================
-- ui settings
-- ================================================
vim.opt.termguicolors = true
vim.opt.updatetime = 250
--
-- ==================================================
-- clipboard settings
-- ==================================================
vim.opt.clipboard:append("unnamedplus")
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})
--
--
--
