-- ~/.config/nvim/lua/config/keybinds.lua

-- ============================================
-- short hand declaration
-- ============================================
local keymap = vim.keymap.set

-- ============================================
-- set leader keys before setting up Lazy
-- ============================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =========================================================================
-- TOGGLE OPTIONS GROUP CONFIGURATIONS (<leader>t)
-- =========================================================================

-- <leader>tw: Toggle Deprecation Warnings (Already Added!)
vim.keymap.set("n", "<leader>tw", function()
	vim.g.deprecation_warnings = not vim.g.deprecation_warnings
	if vim.g.deprecation_warnings then
		vim.notify("⚠️ Deprecation Warnings: ENABLED (Show Logs)", vim.log.levels.WARN)
	else
		vim.notify("🔇 Deprecation Warnings: MUTED (Clean Screen)", vim.log.levels.INFO)
	end
end, { desc = "Toggle Deprecation Warnings" })

-- <leader>tn: Toggle Between Relative and Fixed Line Numbers (Great for Screen Sharing)
vim.keymap.set("n", "<leader>tn", function()
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
	vim.notify("🔢 Relative Numbers: " .. (vim.opt.relativenumber:get() and "ON" or "OFF"))
end, { desc = "Toggle Relative Line Numbers" })

-- <leader>ts: Toggle Spell Checking (Turns cspell/native spelling highlights on/off)
vim.keymap.set("n", "<leader>ts", function()
	vim.opt.spell = not vim.opt.spell:get()
	vim.notify("🔤 Spell Check: " .. (vim.opt.spell:get() and "ON" or "OFF"))
end, { desc = "Toggle Spell Check" })

-- <leader>tw: Toggle Line Wrap (Keeps long HTML lines from sliding off the screen)
vim.keymap.set("n", "<leader>tl", function()
	vim.opt.wrap = not vim.opt.wrap:get()
	vim.notify("↔️ Line Wrap: " .. (vim.opt.wrap:get() and "ON" or "OFF"))
end, { desc = "Toggle Line Wrap" })

-- <leader>td: Toggle Inline LSP Diagnostics (Hides error/warning text while writing code)
vim.keymap.set("n", "<leader>td", function()
	if vim.diagnostic.is_enabled() then
		vim.diagnostic.enable(false)
		vim.notify("🙈 Diagnostics Hidden", vim.log.levels.INFO)
	else
		vim.diagnostic.enable(true)
		vim.notify("👁️ Diagnostics Visible", vim.log.levels.INFO)
	end
end, { desc = "Toggle LSP Diagnostics" })

-- =============================================
-- Toggle comment on current line
-- =============================================
keymap("n", "<leader>cc", "gcc", { remap = true, desc = "Toggle Comment" })

-- ============================================
-- File actions {save and quit}
-- ============================================
keymap("n", "<leader>w", ":w<CR>", { desc = "save file " })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit " })

--===============================================
-- Window navigation
-- ==============================================
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- ==============================================
-- Toggle tree mode
-- ==============================================
keymap("n", "<leader>cd", vim.cmd.Ex, { desc = "toggle tree mode" })

-- ===============================================
-- Map 'jk' to exit Insert or visual mode
-- ===============================================
keymap({ "i", "v" }, "jk", "<Esc>", { desc = "exit Insert mode", noremap = true, silent = true })

-- ===============================================
-- replaces selected text WITHOUT losing what you yanked
-- ===============================================
keymap("x", "p", [["_dp]], { desc = "Paste over selection without losing yanked text" })

-- ===============================================
-- Delete text without saving it to any registers
-- ===============================================
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- ===============================================
-- clear search highlighting
-- ===============================================
keymap("n", "<C-c>", "nohl<CR>", { desc = "Clear search highlighting", silent = true })

-- ===============================================
-- visual line movements
-- ===============================================
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
keymap("v", "K", ":m '>-2<CR>gv=gv", { desc = "moves lines up in visual selection" })
keymap("v", "<", "<gv", { desc = "Unindent and keep selection" })
keymap("v", ">", ">gv", { desc = "Indent and keep selection" })

-- ===============================================
-- join lines
-- ===============================================
keymap("n", "J", "mzJ'z", { desc = "Join lines without moving cursor" })

-- ===============================================
-- center cursor while moving in buffer
-- ===============================================
keymap("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
keymap("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

-- ================================================
-- replace the word at the cursor
-- ================================================
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor" })

-- =================================================
-- Makes an executable file
-- =================================================
keymap("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- =================================================
-- shortcut to restart nvim
-- =================================================
keymap("n", "<leader>re", "<cmd>restart<CR>", { desc = "Restart Neovim (:restart)" })

-- =================================================
-- Use Neovims Native undotree
-- =================================================
keymap("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })
