-- ~/.config/nvim/lua/plugins/editor/which-key.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- vim-fugitive.lua, trouble.lua, telescope.lua, inline.lua,
-- nvim-lint.lua, toggleterm.lua, git.lua, ts-autopairs.lua,
-- treesitter.lua, nvim-lspconfig.lua, lsp_signature.lua,
-- goto-preview.lua, emmet_vim.lua, mason.lua, conform.lua,
-- blink.lua, init.lua, lazy.lua, auto.lua, keybinds.lua, and
-- options.lua, and the spec kept together under its own header.
-- The rocket comments on the <leader>tp / <leader>tP lines are
-- reworded to plain text; the icons in the spec ("Find /
-- Telescope", "Git / Preview", "Toggles/Terminals") are kept
-- exactly, since those are displayed values.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/editor/, so it is covered by
--     the "plugins.editor" import. It loads on event = "VeryLazy".
--   * preset = "modern" and the whole spec below are passed
--     through opts, so which-key.nvim runs on that preset with
--     these labels / groups / mappings added.
--   * CORRECTION -- <leader>tp / <leader>tP ARE defined here:
--     { "<leader>tp", "<cmd>LivePreview<cr>", ... } and
--     { "<leader>tP", "<cmd>LivePreviewStop<cr>", ... } are
--     real which-key spec mappings in this file, not just
--     labels. So the earlier flag that tp / tP have no mapping
--     was wrong -- they live here, not in keybinds.lua. The
--     :LivePreview and :LivePreviewStop commands they call
--     are created in toggleterm.lua's init function, so that
--     file must stay for these two keys to work.
--   * STALE LABEL -- <leader>cc, flagged and left as-is:
--     this file labels <leader>cc "Generate COBOL
--     Boilerplate", but cobol_snippets.lua was changed to
--     <leader>cb for the COBOL boilerplate. This entry is
--     desc-only (no command), so it does not create a
--     <leader>cc mapping -- it only shows a label for a key
--     that no longer does that job, and there is no
--     <leader>cb entry here to label the real key.
--   * LABELS DO NOT MATCH -- Git, flagged and left as-is:
--     this file lists <leader>gb "Toggle Line Blame",
--     <leader>gp "Preview Hunk Float", and <leader>gr
--     "Reset Current Hunk", but git.lua / gitsigns actually
--     uses <leader>gbl, <leader>gph, and <leader>grh for
--     those jobs. Those entries are desc-only too, so they
--     do not create gb / gp / gr mappings. <leader>gd here
--     is labelled "View File Diff Window" -- gitsigns uses
--     <leader>gdf for its diff view, while keybinds.lua's
--     <leader>gd is <cmd>Gdiffsplit<CR>.
--   * <leader>td label matches trouble.lua, flagged:
--     this file labels <leader>td "Buffer Diagnostics Only
--     (Trouble)", which matches trouble.lua's <leader>td
--     (Trouble diagnostics toggle filter.buf=0), not
--     keybinds.lua's <leader>td diagnostic pause / resume.
--     That is the already-flagged <leader>td clash: two
--     different jobs for one key, and this label describes
--     the Trouble job. Left as-is.
--   * Other labels line up with their files: <leader>tc
--     "Floating Command Launcher" with telescope.lua's
--     Floating Terminal Command Launcher, <leader>tq
--     "Quickfix List (Trouble)" and <leader>tx "Diagnostics
--     Panel (Trouble)" with trouble.lua, and <leader>tf /
--     <leader>tg / <leader>th / <leader>tv with the
--     toggleterm / Lazygit toggles. Most spec entries here
--     are desc- or group-only -- they label keys defined in
--     keybinds.lua and the plugin files, they do not define
--     those keys themselves. <leader>tp / <leader>tP above
--     are the exceptions, with a command as the second item.
--   * No autocmds or save hooks here of its own, so nothing
--     overlaps conform.lua's format on save, nvim-lint.lua's
--     lint autocmds, or auto.lua's compile-and-run.

-- ---------------------------------------------------------------------------
-- Which-Key
-- ---------------------------------------------------------------------------
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		spec = {
			-- Top-Level Prefix Definitions
			{ "<leader>e", desc = "Toggle File Explorer" },
			{ "<leader>f", group = "Find / Telescope", icon = "🔍" },
			{ "<leader>g", group = "Git / Preview", icon = "📊" },
			{ "<leader>t", group = "Toggles/Terminals", icon = "⚙️" },

			-- Git Details Submenu Labels
			{ "<leader>gb", desc = "Toggle Line Blame" },
			{ "<leader>gd", desc = "View File Diff Window" },
			{ "<leader>gp", desc = "Preview Hunk Float" },
			{ "<leader>gr", desc = "Reset Current Hunk" },

			-- Toggles / Terminals Child Items
			{ "<leader>tc", desc = "Floating Command Launcher" },
			{ "<leader>td", desc = "Buffer Diagnostics Only (Trouble)" },
			{ "<leader>tD", desc = "Toggle Inline LSP Diagnostics" },
			{ "<leader>tf", desc = "Toggle Floating Terminal Shell" },
			{ "<leader>tg", desc = "Toggle Lazygit Dashboard" },
			{ "<leader>th", desc = "Toggle Horizontal Terminal Split" },
			{ "<leader>tl", desc = "Toggle Line Wrap" },
			{ "<leader>tn", desc = "Toggle Relative Line Numbers" },
			{ "<leader>tp", "<cmd>LivePreview<cr>", desc = "Start Realtime HTML Viewer" }, -- Added Start Preview
			{ "<leader>tP", "<cmd>LivePreviewStop<cr>", desc = "Stop Realtime HTML Viewer" }, -- Added Stop Preview
			{ "<leader>tq", desc = "Quickfix List (Trouble)" },
			{ "<leader>ts", desc = "Toggle Spell Check" },
			{ "<leader>tv", desc = "Toggle Vertical Terminal Split" },
			{ "<leader>tw", desc = "Toggle Deprecation Warnings" },
			{ "<leader>tx", desc = "Diagnostics Panel (Trouble)" },
			{ "<leader>sa", desc = "Add Word to cspell Dictionary" },
			{ "<leader>cc", desc = "Generate COBOL Boilerplate" },
			{ "<leader>hs", desc = "Split Window Horizontally" },
			{ "<leader>sh", desc = "Help Pages (Snacks)" },
			{ "<leader>r", desc = "Replace word cursor" },
		},
	},
}
