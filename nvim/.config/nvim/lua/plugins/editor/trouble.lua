-- ~/.config/nvim/lua/plugins/editor/trouble.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- telescope.lua, inline.lua, nvim-lint.lua, toggleterm.lua,
-- git.lua, ts-autopairs.lua, treesitter.lua, nvim-lspconfig.lua,
-- lsp_signature.lua, goto-preview.lua, emmet_vim.lua, mason.lua,
-- conform.lua, blink.lua, init.lua, lazy.lua, auto.lua,
-- keybinds.lua, and options.lua, and the spec kept together
-- under its own header.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/editor/, so it is covered by
--     the "plugins.editor" import.
--   * Lazy loading: cmd = "Trouble" and the keys list below are
--     the triggers -- lazy.nvim loads trouble.nvim on the first
--     :Trouble command or on <leader>tx, <leader>td, or
--     <leader>tq, not at startup.
--   * opts = {} means Trouble runs entirely on its modern v3
--     defaults -- there is no config function and no opts to
--     merge or override in this file.
--   * DIRECT CLASH -- <leader>td, flagged and left as-is:
--     here <leader>td is Trouble diagnostics toggle
--     filter.buf=0 ("Buffer Diagnostics Only (Trouble)"), for
--     the current buffer only, while keybinds.lua maps
--     <leader>td globally to its diagnostic pause / resume
--     toggle (vim.diagnostic.pause() / resume(), "Toggle
--     Inline LSP Diagnostics"). Those are two different jobs
--     for the exact same key, in the same mode, so only one
--     of them can win -- the other will not do what its
--     description says. Decide which job <leader>td should
--     keep and move the other to a different key; nothing
--     was changed here.
--   * <leader>tx and <leader>tq match the README: <leader>tx
--     is Trouble diagnostics toggle (Diagnostics Panel) and
--     <leader>tq is Trouble qflist toggle (Quickfix List).
--     Neither is mapped in keybinds.lua, so neither clashes
--     there -- they only share the <leader>t prefix with
--     keybinds.lua's toggle group (td, tf, tg, th, ti, tl,
--     tn, ts, tv, tw).
--   * Those three keys show what Trouble displays, they do
--     not change diagnostic settings: options.lua's signs,
--     underline, severity_sort, virtual_text, and float, and
--     inline.lua's virtual_text = false, are untouched by
--     this file. Trouble is a separate panel view of the same
--     diagnostics.
--   * No autocmds or save hooks here of its own, so nothing
--     overlaps conform.lua's format on save, nvim-lint.lua's
--     lint autocmds, or auto.lua's compile-and-run. Its only
--     triggers are the lazy.nvim cmd and keys above.

-- ---------------------------------------------------------------------------
-- Trouble
-- ---------------------------------------------------------------------------
return {
	"folke/trouble.nvim",
	opts = {}, -- Uses modern v3 default configurations out-of-the-box
	cmd = "Trouble",
	keys = {
		{
			"<leader>tx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics Panel (Trouble)",
		},
		{
			"<leader>td",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics Only (Trouble)",
		},
		{
			"<leader>tq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}
