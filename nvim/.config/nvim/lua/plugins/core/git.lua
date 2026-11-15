-- ~/.config/nvim/lua/plugins/core/git.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- ts-autopairs.lua, treesitter.lua, nvim-lspconfig.lua,
-- lsp_signature.lua, goto-preview.lua, emmet_vim.lua, mason.lua,
-- conform.lua, blink.lua, init.lua, lazy.lua, auto.lua,
-- keybinds.lua, and options.lua, and the spec kept together
-- under its own header.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/core/, so it is covered by
--     the "plugins.core" import.
--   * Loads on BufReadPre / BufNewFile, not at startup.
--   * Sign column lines up: signcolumn = true below, and
--     options.lua sets vim.opt.signcolumn = "yes", so the
--     column gitsigns draws in is always shown. The sign texts
--     here (add / change "┃", delete "_", topdelete "‾",
--     changedelete "~", untracked "┆") are gitsigns' own signs,
--     separate from options.lua's diagnostic signs -- the two
--     share the column but do not overwrite each other.
--   * current_line_blame = true means inline blame is ON by
--     default, with delay = 400 and virt_text_pos = "eol" from
--     current_line_blame_opts. <leader>gbl below toggles it
--     off / on in a buffer.
--   * CLASH -- ]c / [c are mapped in BOTH places, left as-is:
--     keybinds.lua maps them globally in Normal mode to
--     <cmd>GitGutterNextHunk<CR> / <cmd>GitGutterPrevHunk<CR>,
--     and this file maps them buffer-locally in on_attach to
--     gitsigns' next_hunk / prev_hunk. Buffer-local wins where
--     gitsigns has attached (a buffer in a git repo), so there
--     ]c / [c use gitsigns; in buffers gitsigns has not
--     attached to, the keybinds.lua GitGutter mappings are the
--     ones still in effect. The two also behave differently:
--     this file's versions are expr mappings that return the
--     native "]c" / "[c" in diff mode (vim.wo.diff), keeping
--     native diff navigation, and use vim.schedule to jump.
--     Note: no vim-gitgutter plugin spec has appeared in the
--     plugin files cleaned so far, so the GitGutter commands in
--     keybinds.lua may have no plugin behind them -- gitsigns
--     looks like its replacement. Decide which set to keep;
--     nothing was removed here.
--   * PREFIX CLASH -- <leader>gd vs <leader>gdf, left as-is:
--     keybinds.lua maps <leader>gd globally to
--     <cmd>Gdiffsplit<CR> ("Git Diff Split"), and this file maps
--     <leader>gdf buffer-locally to gs.diffthis ("View File
--     Diff Window"). <leader>gd is the start of <leader>gdf,
--     so in a gitsigns buffer Neovim waits a moment after
--     <leader>gd to see if "f" follows -- the same kind of
--     prefix wait as <leader>d / <leader>dl and <leader>s /
--     <leader>sv / <leader>sh in keybinds.lua. The two also do
--     a similar job (a diff view of the file), from different
--     plugins.
--   * No other <leader>g clashes: keybinds.lua has <leader>gs
--     (Git Status Pane) and <leader>gc (Git Commit), and this
--     file's <leader>gph, <leader>gbl, and <leader>grh are
--     different keys. No clash with nvim-lspconfig.lua's
--     LspAttach keys (K, gd, gD, gi, gr, <leader>cr,
--     <leader>ca) -- note plain "gd" there is go-to-definition,
--     while <leader>gd / <leader>gdf here are diff views.
--   * All of this file's on_attach mappings are buffer-local
--     (the map() helper sets opts.buffer = bufnr), so they only
--     exist in buffers gitsigns attaches to, unlike
--     keybinds.lua's global mappings.
--   * No autocmds or save hooks here of its own, so nothing
--     overlaps conform.lua's format on save or auto.lua's
--     compile-and-run. Its only events are the lazy.nvim
--     loading events, BufReadPre / BufNewFile.

-- ---------------------------------------------------------------------------
-- Gitsigns
-- ---------------------------------------------------------------------------
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true,
		watch_gitdir = { follow_files = true },
		current_line_blame = true, -- Adds subtle dim ghost-text inline blame
		current_line_blame_opts = {
			delay = 400,
			virt_text_pos = "eol",
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation keys to jump between modified hunks
			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Next Git Hunk" })

			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Previous Git Hunk" })

			-- Bindings matching your Which-Key menu requirements
			map("n", "<leader>gph", gs.preview_hunk, { desc = "Preview Hunk Float" })
			map("n", "<leader>gbl", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
			map("n", "<leader>gdf", gs.diffthis, { desc = "View File Diff Window" })
			map("n", "<leader>grh", gs.reset_hunk, { desc = "Reset Current Hunk" })
		end,
	},
}
