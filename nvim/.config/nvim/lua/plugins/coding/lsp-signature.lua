-- ~/.config/nvim/lua/plugins/coding/lsp_signature.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- goto-preview.lua, emmet_vim.lua, mason.lua, conform.lua,
-- blink.lua, init.lua, lazy.lua, auto.lua, keybinds.lua, and
-- options.lua, and the spec kept together under its own header.
-- The original numbered header ("4. LSP SIGNATURE FLOATING
-- HELPER") is dropped, like the other cleaned files.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/coding/ in your tree, so it
--     is covered by the "plugins.coding" import.
--   * Lazy loading: event = "LspAttach" means lazy.nvim loads
--     this plugin only when an LSP server first attaches to a
--     buffer, not at startup.
--   * bind = true is required here, not optional: without it
--     the border config in handler_opts does not get registered,
--     so the rounded border below would not apply.
--   * Border styles agree. handler_opts border = "rounded"
--     below matches blink.lua's documentation window
--     (border = "rounded") and options.lua's diagnostic float
--     (border = "rounded").
--   * No overlap with blink.lua today. blink.lua shows the
--     completion menu and its documentation preview, and it has
--     no signature section enabled, so this plugin is what
--     shows the function signature / parameter hint as you
--     type. If you later enable signature help in blink.lua,
--     the two could both try to show a signature window.
--     Left as-is.
--   * Depends on LSP, like goto-preview.lua: with no server
--     attached there is no signature to show. As flagged in
--     mason.lua, there is no mason-lspconfig bridge or
--     ensure_installed list in your tree, so servers are not
--     installed or enabled automatically by Mason -- any server
--     setup has to live in nvim-lspconfig.lua. Left as-is.
--   * No clash with auto.lua. auto.lua listens for LspProgress
--     for its LSP progress notifications; this file uses
--     LspAttach as its lazy.nvim loading event -- different
--     events, no overlap.
--   * No keymaps are defined in this file itself, and no
--     autocmds or save hooks, so nothing clashes with
--     keybinds.lua or emmet_vim.lua, and nothing overlaps
--     auto.lua's BufWritePost compile-and-run or conform.lua's
--     BufWritePre format on save.
--   * Only two options are set: bind and handler_opts. Every
--     other lsp_signature option keeps the plugin's own
--     defaults, because nothing else is passed in opts.
--     Left as-is.

-- ---------------------------------------------------------------------------
-- LSP Signature
-- ---------------------------------------------------------------------------
return {
	"ray-x/lsp_signature.nvim",
	event = "LspAttach",
	opts = {
		bind = true,
		handler_opts = { border = "rounded" },
	},
}
