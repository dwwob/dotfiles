-- ~/.config/nvim/lua/config/keybinds.lua

-- ============================================
-- Short-hand declarations & option helpers
-- ============================================
local keymap = vim.keymap.set
local default_opts = { silent = true }

-- Helper function to cleanly combine silent defaults with unique descriptions
local function opts(description)
	return vim.tbl_deep_extend("force", default_opts, { desc = description })
end

-- =========================================================================
-- TOGGLE OPTIONS GROUP CONFIGURATIONS (<leader>t)
-- =========================================================================

-- <leader>tw: Toggle Deprecation Warnings
keymap("n", "<leader>tw", function()
	vim.g.deprecation_warnings = not vim.g.deprecation_warnings
	if vim.g.deprecation_warnings then
		vim.notify("⚠️ Deprecation Warnings: ENABLED (Show Logs)", vim.log.levels.WARN)
	else
		vim.notify("🔇 Deprecation Warnings: MUTED (Clean Screen)", vim.log.levels.INFO)
	end
end, opts("Toggle Deprecation Warnings"))

-- <leader>tn: Toggle between Relative and Fixed Absolute Line Numbers
keymap("n", "<leader>tn", function()
	vim.o.relativenumber = not vim.o.relativenumber
	local status = vim.o.relativenumber and "RELATIVE" or "ABSOLUTE"
	vim.notify("🔢 Line Numbers: " .. status, vim.log.levels.INFO)
end, opts("Toggle Relative Line Numbers"))

-- <leader>ts: Toggle Spell Checking
keymap("n", "<leader>ts", function()
	vim.o.spell = not vim.o.spell
	vim.notify("🔤 Spell Check: " .. (vim.o.spell and "ON" or "OFF"), vim.log.levels.INFO)
end, opts("Toggle Spell Check"))

-- <leader>tl: Toggle Line Wrap
keymap("n", "<leader>tl", function()
	vim.o.wrap = not vim.o.wrap
	vim.notify("↔️ Line Wrap: " .. (vim.o.wrap and "ON" or "OFF"), vim.log.levels.INFO)
end, opts("Toggle Line Wrap"))

-- <leader>td: Toggle Inline LSP Diagnostics (Updated for Neovim 12.5+)
keymap("n", "<leader>td", function()
	if vim.diagnostic.is_paused() then
		vim.diagnostic.resume()
		vim.notify("👁️ Diagnostics Visible", vim.log.levels.INFO)
	else
		vim.diagnostic.pause()
		vim.notify("🙈 Diagnostics Hidden", vim.log.levels.INFO)
	end
end, opts("Toggle Inline LSP Diagnostics"))

-- =========================================================================
-- TERMINAL AND LAZYGIT LAYOUT TOGGLES (<leader>t)
-- =========================================================================

-- <leader>tg: Toggle Floating Lazygit Popup Application
keymap("n", "<leader>tg", function()
	if _G.toggle_lazygit then
		_G.toggle_lazygit()
	else
		vim.notify("❌ Lazygit module not loaded yet", vim.log.levels.ERROR)
	end
end, opts("Toggle Lazygit Dashboard"))

-- <leader>th: Toggle Horizontal Split Terminal Window
keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", opts("Toggle Horizontal Terminal Split"))

-- <leader>tv: Toggle Vertical Split Terminal Window
keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", opts("Toggle Vertical Terminal Split"))

-- <leader>tf: Toggle General Floating Terminal window
keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", opts("Toggle Floating Terminal Shell"))

-- =============================================
-- Toggle comment on current line
-- =============================================
keymap("n", "<leader>cc", "gcc", { remap = true, silent = true, desc = "Toggle Comment" })

-- ============================================
-- File actions {save and quit}
-- ============================================
keymap("n", "<leader>w", ":w<CR>", opts("Save file"))
keymap("n", "<leader>q", ":q<CR>", opts("Quit"))

--===============================================
-- Window navigation
-- ==============================================
keymap("n", "<leader>sv", "<cmd>vsplit<CR>", opts("Split Window Vertically"))
keymap("n", "<leader>sh", "<cmd>split<CR>", opts("Split Window Horizontally"))
keymap("n", "<C-h>", "<C-w>h", opts("Go to Left Window"))
keymap("n", "<C-j>", "<C-w>j", opts("Go to Lower Window"))
keymap("n", "<C-k>", "<C-w>k", opts("Go to Upper Window"))
keymap("n", "<C-l>", "<C-w>l", opts("Go to Right Window"))

-- ==============================================
-- Toggle tree mode / File Explorer Hook
-- ==============================================
keymap("n", "<leader>e", "<cmd>Neotree toggle<cr>", opts("Toggle File Explorer"))
keymap("n", "<leader>cd", vim.cmd.Ex, opts("Toggle Netrw Explore Mode"))

-- ===============================================
-- Map 'jk' to exit Insert or visual mode
-- ===============================================
keymap({ "i", "v" }, "jk", "<Esc>", { desc = "Exit Insert mode", noremap = true, silent = true })

-- ===============================================
-- Replaces selected text WITHOUT losing what you yanked
-- ===============================================
keymap("x", "p", [["_dp]], opts("Paste over selection without losing yanked text"))

-- ===============================================
-- Delete text without saving it to any registers
-- ===============================================
keymap({ "n", "v" }, "<leader>d", [["_d]], opts("Delete without yanking"))

-- ===============================================
-- Clear search highlighting
-- ===============================================
keymap("n", "<leader>ti", "<cmd>nohlsearch<cr>", opts("Clear search highlighting"))

-- ===============================================
-- Visual line movements
-- ===============================================
keymap("v", "J", ":m '>+1<CR>gv=gv", opts("Moves lines down in visual selection"))
keymap("v", "K", ":m '>-2<CR>gv=gv", opts("Moves lines up in visual selection"))
keymap("v", "<", "<gv", opts("Unindent and keep selection"))
keymap("v", ">", ">gv", opts("Indent and keep selection"))

-- ===============================================
-- Join lines
-- ===============================================
keymap("n", "J", "mzJ'z", opts("Join lines without moving cursor"))

-- ===============================================
-- Center cursor while moving in buffer
-- ===============================================
keymap("n", "<C-d>", "<C-d>zz", opts("Move down in buffer with cursor centered"))
keymap("n", "<C-u>", "<C-u>zz", opts("Move up in buffer with cursor centered"))
keymap("n", "n", "nzzzv", opts("Next search result cursor centered"))
keymap("n", "N", "Nzzzv", opts("Previous search result cursor centered"))

-- ================================================
-- Replace the word at the cursor
-- ================================================
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts("Replace word cursor"))

-- =================================================
-- Makes an executable file
-- =================================================
keymap("n", "<leader>X", "<cmd>!chmod +x %<CR>", opts("Makes file executable"))

-- =================================================
-- Shortcut to restart nvim
-- =================================================
keymap("n", "<leader>re", "<cmd>restart<CR>", opts("Restart Neovim (:restart)"))

-- ==================================================
-- Telescope Fuzzy Finder Fast Hooks
-- ==================================================
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts("Find Files"))
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts("Live Grep"))
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts("Find Buffers"))
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts("Help Tags"))

-- ===================================================
-- Fugitive Git Control Basics
-- ===================================================
keymap("n", "<leader>gs", "<cmd>Git<CR>", opts("Git Status Pane"))
keymap("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", opts("Git Diff Split"))
keymap("n", "<leader>gc", "<cmd>Git commit<CR>", opts("Git Commit"))

-- ====================================================
-- GitGutter Hunk Jumps
-- ====================================================
keymap("n", "]c", "<cmd>GitGutterNextHunk<CR>", opts("Jump to Next Git Hunk"))
keymap("n", "[c", "<cmd>GitGutterPrevHunk<CR>", opts("Jump to Previous Git Hunk"))

-- ====================================================
-- Native LSP Diagnostics Fast-Jumps
-- ====================================================
keymap("n", "[d", vim.diagnostic.goto_prev, opts("Go to Previous LSP Diagnostic Error"))
keymap("n", "]d", vim.diagnostic.goto_next, opts("Go to Next LSP Diagnostic Error"))
keymap("n", "<leader>dl", vim.diagnostic.setloclist, opts("Open LSP Diagnostic Local List"))

-- =========================================================================
-- CONDITIONAL AUTO-PAIRING FOR TEXT FILES
-- =========================================================================

local function is_text_file()
	return vim.bo.filetype == "text" or vim.bo.filetype == "plaintext" or vim.bo.filetype == ""
end

local bracket_pairs = {
	["("] = ")",
	["["] = "]",
	["{"] = "}",
	['"'] = '"',
	["`"] = "`",
}

-- -- Apply conditional keymaps for standard brackets and double quotes
-- for open, close in pairs(bracket_pairs) do
-- 	keymap("i", open, function()
-- 		if is_text_file() then
-- 			return open .. close .. "<Left>"
-- 		else
-- 			return open
-- 		end
-- 	end, { expr = true, noremap = true, silent = true, desc = "Text file auto-pairing" })
-- end
--
-- -- Isolated single quote definition with expression rendering
-- keymap("i", "'", function()
-- 	return "'"
-- end, { expr = true, noremap = true, silent = true, desc = "Literal single quotes with zero auto-pairing" })
--
-- -- Unified backspace cleaning engine for text boundaries
-- keymap("i", "<BS>", function()
-- 	if is_text_file() then
-- 		-- FIX: Direct array assignment completely bypasses the deprecated/broken unpack function
-- 		local cursor = vim.api.nvim_win_get_cursor(0)
-- 		local col = cursor[2] -- Index 2 is the exact character column tracking byte
--
-- 		local line = vim.api.nvim_get_current_line()
-- 		local left_char = line:sub(col, col)
-- 		local right_char = line:sub(col + 1, col + 1)
--
-- 		local pairs_str = '()[]{}""``'
-- 		for i = 1, #pairs_str, 2 do
-- 			if left_char == pairs_str:sub(i, i) and right_char == pairs_str:sub(i + 1, i + 1) then
-- 				return "<BS><Del>"
-- 			end
-- 		end
-- 	end
-- 	return "<BS>"
-- end, { expr = true, noremap = true, silent = true, desc = "Smart backspace for standard text pairs" })
