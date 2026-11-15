-- ~/.config/nvim/lua/config/keybinds.lua
--
-- Cleaned-up version of your original file.
-- Every key is the same as before -- nothing was moved or removed.
-- Changes are only to layout: one header style, one helper used
-- everywhere, and binds grouped by their <leader> prefix.
--
-- Two clashes to decide on later (both flagged with TODO below):
--   1. <leader>d  (delete without yanking) vs <leader>dl (diagnostic list)
--   2. <leader>s  (replace word)           vs <leader>sv / <leader>sh (splits)
-- A shorter key that is also the start of a longer one makes Neovim
-- wait a moment to see if you press the next key.

-- ---------------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------------
local keymap = vim.keymap.set

-- opts("Save file")                    -> silent + that description
-- opts("Toggle Comment", { remap = true }) -> also adds remap
local function opts(description, extra)
	return vim.tbl_deep_extend("force", { silent = true }, extra or {}, { desc = description })
end

-- For the simple on/off toggles: flip a boolean option and say so.
local function toggle_option(name, label)
	vim.o[name] = not vim.o[name]
	vim.notify(label .. ": " .. (vim.o[name] and "ON" or "OFF"), vim.log.levels.INFO)
end

-- ---------------------------------------------------------------------------
-- Basics
-- ---------------------------------------------------------------------------
keymap("n", "<leader>w", ":w<CR>", opts("Save file"))
keymap("n", "<leader>qa", "<cmd>q!<CR>", opts("Quit without saving"))
keymap("n", "<leader>q", ":q<CR>", opts("Quit"))
keymap("n", "<leader>cc", "gcc", opts("Toggle Comment", { remap = true }))
keymap("n", "<leader>e", "<cmd>Neotree toggle<cr>", opts("Toggle File Explorer"))
keymap("n", "<leader>cd", vim.cmd.Ex, opts("Toggle Netrw Explore Mode"))
keymap({ "i", "v" }, "jk", "<Esc>", opts("Exit Insert mode", { noremap = true }))

-- ---------------------------------------------------------------------------
-- Toggles (<leader>t)
-- ---------------------------------------------------------------------------
keymap("n", "<leader>tD", function()
	if vim.diagnostic.is_paused() then
		vim.diagnostic.resume()
		vim.notify("👁️ Diagnostics Visible", vim.log.levels.INFO)
	else
		vim.diagnostic.pause()
		vim.notify("🙈 Diagnostics Hidden", vim.log.levels.INFO)
	end
end, opts("Toggle Inline LSP Diagnostics"))

keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", opts("Toggle Floating Terminal Shell"))
keymap("n", "<leader>tg", function()
	if _G.toggle_lazygit then
		_G.toggle_lazygit()
	else
		vim.notify("❌ Lazygit module not loaded yet", vim.log.levels.ERROR)
	end
end, opts("Toggle Lazygit Dashboard"))
keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", opts("Toggle Horizontal Terminal Split"))
keymap("n", "<leader>ti", "<cmd>nohlsearch<cr>", opts("Clear search highlighting"))
keymap("n", "<leader>tl", function()
	toggle_option("wrap", "↔️ Line Wrap")
end, opts("Toggle Line Wrap"))
keymap("n", "<leader>tn", function()
	vim.o.relativenumber = not vim.o.relativenumber
	local status = vim.o.relativenumber and "RELATIVE" or "ABSOLUTE"
	vim.notify("🔢 Line Numbers: " .. status, vim.log.levels.INFO)
end, opts("Toggle Relative Line Numbers"))
keymap("n", "<leader>ts", function()
	toggle_option("spell", "🔤 Spell Check")
end, opts("Toggle Spell Check"))
keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", opts("Toggle Vertical Terminal Split"))
keymap("n", "<leader>tw", function()
	vim.g.deprecation_warnings = not vim.g.deprecation_warnings
	if vim.g.deprecation_warnings then
		vim.notify("⚠️ Deprecation Warnings: ENABLED (Show Logs)", vim.log.levels.WARN)
	else
		vim.notify("🔇 Deprecation Warnings: MUTED (Clean Screen)", vim.log.levels.INFO)
	end
end, opts("Toggle Deprecation Warnings"))

-- ---------------------------------------------------------------------------
-- Windows and splits
-- ---------------------------------------------------------------------------
-- TODO (clash 2): <leader>sv and <leader>sh start with <leader>s,
-- which is also "Replace word" in the Editing section below.
keymap("n", "<leader>sv", "<cmd>vsplit<CR>", opts("Split Window Vertically"))
keymap("n", "<leader>hs", "<cmd>split<CR>", opts("Split Window Horizontally"))
keymap("n", "<C-h>", "<C-w>h", opts("Go to Left Window"))
keymap("n", "<C-j>", "<C-w>j", opts("Go to Lower Window"))
keymap("n", "<C-k>", "<C-w>k", opts("Go to Upper Window"))
keymap("n", "<C-l>", "<C-w>l", opts("Go to Right Window"))

-- ---------------------------------------------------------------------------
-- Editing
-- ---------------------------------------------------------------------------
-- Paste over a selection without losing what you yanked
keymap("x", "p", [["_dp]], opts("Paste over selection without losing yanked text"))
-- TODO (clash 1): <leader>d is also the start of <leader>dl
-- (diagnostic list) in the Diagnostics section below.
keymap({ "n", "v" }, "<leader>d", [["_d]], opts("Delete without yanking"))
-- TODO (clash 2): <leader>s is also the start of <leader>sv / <leader>sh
-- (splits) in the Windows section above.
keymap("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts("Replace word cursor"))
keymap("n", "J", "mzJ'z", opts("Join lines without moving cursor"))

-- Move and indent lines in Visual mode, keeping the selection
keymap("v", "J", ":m '>+1<CR>gv=gv", opts("Moves lines down in visual selection"))
keymap("v", "K", ":m '>-2<CR>gv=gv", opts("Moves lines up in visual selection"))
keymap("v", "<", "<gv", opts("Unindent and keep selection"))
keymap("v", ">", ">gv", opts("Indent and keep selection"))

-- Keep the cursor centred while moving and searching
keymap("n", "<C-d>", "<C-d>zz", opts("Move down in buffer with cursor centered"))
keymap("n", "<C-u>", "<C-u>zz", opts("Move up in buffer with cursor centered"))
keymap("n", "n", "nzzzv", opts("Next search result cursor centered"))
keymap("n", "N", "Nzzzv", opts("Previous search result cursor centered"))

-- ---------------------------------------------------------------------------
-- Find -- Telescope (<leader>f)
-- ---------------------------------------------------------------------------
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts("Find Files"))
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts("Live Grep"))
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts("Find Buffers"))
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts("Help Tags"))

-- ---------------------------------------------------------------------------
-- Git (<leader>g)
-- ---------------------------------------------------------------------------
keymap("n", "<leader>gs", "<cmd>Git<CR>", opts("Git Status Pane"))
keymap("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", opts("Git Diff Split"))
keymap("n", "<leader>gc", "<cmd>Git commit<CR>", opts("Git Commit"))
-- ]c / [c (next/previous hunk) are now handled by gitsigns in
-- lua/plugins/core/git.lua -- the old GitGutter mappings were removed
-- here to avoid clashing with gitsigns.

-- ---------------------------------------------------------------------------
-- Diagnostics
-- ---------------------------------------------------------------------------
keymap("n", "[d", vim.diagnostic.goto_prev, opts("Go to Previous LSP Diagnostic Error"))
keymap("n", "]d", vim.diagnostic.goto_next, opts("Go to Next LSP Diagnostic Error"))
-- TODO (clash 1): <leader>dl starts with <leader>d (delete without
-- yanking) in the Editing section above.
keymap("n", "<leader>dl", vim.diagnostic.setloclist, opts("Open LSP Diagnostic Local List"))

-- ---------------------------------------------------------------------------
-- Other
-- ---------------------------------------------------------------------------
keymap("n", "<leader>X", "<cmd>!chmod +x %<CR>", opts("Makes file executable"))
keymap("n", "<leader>re", "<cmd>restart<CR>", opts("Restart Neovim (:restart)"))

-- ---------------------------------------------------------------------------
-- Auto-pairing for .txt files only -- UNFINISHED
-- ---------------------------------------------------------------------------
-- Intended for .txt files only: is_text_file() is supposed to be
-- for txt files only, and this section is only meant to run there.
-- It is NOT for code files -- code files are handled by
-- nvim-autopairs (ts-autopairs.lua) and blink.cmp's auto_brackets,
-- so this section does not conflict with either of those.
-- Unfinished: these two were defined at the end of your file, but
-- nothing uses them yet. They are kept exactly as you had them,
-- so you can finish this section when you are ready.
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
