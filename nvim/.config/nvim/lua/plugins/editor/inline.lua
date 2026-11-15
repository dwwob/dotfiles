-- ~/.config/nvim/lua/plugins/editor/inline.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- nvim-lint.lua, toggleterm.lua, git.lua, ts-autopairs.lua,
-- treesitter.lua, nvim-lspconfig.lua, lsp_signature.lua,
-- goto-preview.lua, emmet_vim.lua, mason.lua, conform.lua,
-- blink.lua, init.lua, lazy.lua, auto.lua, keybinds.lua, and
-- options.lua, and the spec kept together under its own header.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/editor/, so it is covered by
--     the "plugins.editor" import.
--   * Lazy loading: event = "VeryLazy" with priority = 1000
--     means lazy.nvim loads this plugin after startup, not
--     during it -- which decides the virtual_text clash below.
--   * CLASH -- virtual_text is set in BOTH places, left as-is:
--     options.lua sets virtual_text = true in its global
--     vim.diagnostic.config(), and this file's config sets
--     vim.diagnostic.config({ virtual_text = false }) globally.
--     options.lua runs at startup and this plugin loads on
--     VeryLazy afterwards, so this file's false is the one in
--     effect once startup finishes: Neovim's default virtual
--     text stays off, and tiny-inline-diagnostic is the inline
--     display instead. That is what this plugin is for, so the
--     two settings are not both active -- the later one wins.
--   * This call only changes virtual_text. The rest of
--     options.lua's diagnostic config -- signs, underline = true,
--     severity_sort = true, and the rounded float -- is left
--     untouched by it, so gutter signs (including the write_good
--     "✎" sign added in nvim-lint.lua, in its own namespace),
--     underlines, and floating windows still work as set there.
--   * That also explains the write-good behaviour you saw:
--     tiny-inline-diagnostic shows its inline diagnostic text
--     for the current line, so with default virtual text off,
--     a write-good warning shows inline text only when you are
--     on that line. That is this plugin's display, not
--     nvim-lint failing to lint the rest of the file --
--     nvim-lint.lua still lints markdown and text on BufEnter,
--     BufWritePost, and InsertLeave, and the gutter sign and
--     underline still mark the other lines.
--   * setup() is called with no arguments, so the plugin runs
--     entirely on its own defaults -- there are no opts to
--     merge or override in this file.
--   * No keymaps are defined in this file itself, so nothing
--     here clashes with keybinds.lua, nvim-lspconfig.lua's
--     LspAttach keymaps, or goto-preview.lua.
--   * No autocmds or save hooks here of its own, so nothing
--     overlaps conform.lua's format on save or nvim-lint.lua's
--     lint autocmds. Its only event is the lazy.nvim loading
--     event, VeryLazy.

-- ---------------------------------------------------------------------------
-- Tiny Inline Diagnostic
-- ---------------------------------------------------------------------------
return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup()
		vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
	end,
}
