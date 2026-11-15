-- ~/.config/nvim/lua/plugins/coding/mason.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- conform.lua, blink.lua, cobol_snippets.lua, init.lua, lazy.lua,
-- auto.lua, keybinds.lua, and options.lua, and the spec kept
-- together under its own header. The top line is corrected from
-- the dotfiles path in your paste to the config path above.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/coding/ in your tree, so it
--     is covered by the "plugins.coding" import.
--   * Lazy loading: cmd = "Mason" means lazy.nvim loads this
--     plugin only when you run :Mason, not at startup. That is
--     fine for an installer you open by hand, and nothing in
--     the other files you sent calls Mason at startup.
--   * No LSP configuration in this file itself. Despite the
--     original header's "native LSP configuration" wording,
--     there are no vim.lsp calls and no server list here --
--     opts = {} leaves Mason on its defaults. Any server setup
--     has to live in nvim-lspconfig.lua, in the same
--     lua/plugins/coding/ folder.
--   * No bridge in your tree: your plugins/coding/ list has
--     mason.lua and nvim-lspconfig.lua, but no
--     mason-lspconfig.lua and no mason-tool-installer.lua.
--     So this spec on its own does not automatically install
--     or enable any LSP servers -- servers are installed by
--     hand through the :Mason window. Left as-is.
--   * Same gap for tools: there is no ensure_installed list
--     here, so Mason does not automatically install the
--     formatters conform.lua needs (stylua, prettier, isort,
--     black, clang_format, google-java-format, shfmt) or
--     the linters nvim-lint.lua needs. Those have to be
--     installed by hand through :Mason or your system
--     packages, otherwise conform's lsp_format = "fallback"
--     is what covers a missing formatter. Left as-is.
--   * No keymaps, autocmds, or events here, only the Mason
--     command, so nothing clashes with keybinds.lua,
--     auto.lua, blink.lua, or conform.lua.

-- ---------------------------------------------------------------------------
-- Mason
-- ---------------------------------------------------------------------------
return {
	"williamboman/mason.nvim",
	cmd = "Mason",
	opts = {},
}
