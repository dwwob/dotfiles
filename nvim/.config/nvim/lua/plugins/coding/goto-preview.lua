-- ~/.config/nvim/lua/plugins/coding/goto-preview.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- emmet_vim.lua, mason.lua, conform.lua, blink.lua, init.lua,
-- lazy.lua, auto.lua, keybinds.lua, and options.lua, and the spec
-- kept together under its own header.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/coding/ in your tree, so it
--     is covered by the "plugins.coding" import.
--   * Lazy loading: event = "BufRead" means lazy.nvim loads this
--     plugin when the first buffer is read, not at startup.
--   * Setup style kept as-is: this file uses a config function
--     that calls require("goto-preview").setup(...) directly,
--     rather than the opts = {} style used in mason.lua and
--     blink.lua. Both styles work with lazy.nvim.
--   * Default mappings: default_mappings = true below turns on
--     the plugin's normal-mode mappings -- gpd (definition),
--     gpt (type definition), gpi (implementation), gpD
--     (declaration), gpr (references), and gP (close all preview
--     windows).
--   * No clash with keybinds.lua. keybinds.lua has no "gp"
--     mappings and no gpd / gpt / gpi / gpD / gpr / gP mappings:
--     its LSP keys are [d / ]d and <leader>dl for diagnostics,
--     and its comment key is <leader>cc, not a "g" key. So the
--     mappings above are free to use.
--   * No clash with blink.lua or emmet_vim.lua. Those work in
--     Insert mode -- blink with <Tab> / <S-Tab> / <CR>, Emmet
--     with ",," -- while goto-preview's mappings are Normal
--     mode only.
--   * Depends on LSP: the previews are LSP definition, type
--     definition, implementation, declaration, and references
--     calls shown in floating windows, so a buffer needs an LSP
--     server attached for them to show anything. As flagged in
--     mason.lua, there is no mason-lspconfig bridge or
--     ensure_installed list in your tree, so servers are not
--     installed or enabled automatically by Mason -- any server
--     setup has to live in nvim-lspconfig.lua. Left as-is.
--   * Only one setup option is set: default_mappings. Width,
--     height, border, and every other goto-preview option keep
--     the plugin's own defaults, because nothing else is passed
--     to setup() here. Left as-is.
--   * No autocmds or save hooks here of its own, so nothing
--     overlaps auto.lua's BufWritePost compile-and-run or
--     conform.lua's BufWritePre format on save. Its only event
--     is the lazy.nvim loading event, BufRead.

-- ---------------------------------------------------------------------------
-- Goto Preview
-- ---------------------------------------------------------------------------
return {
	"rmagatti/goto-preview",
	event = "BufRead",
	config = function()
		require("goto-preview").setup({
			default_mappings = true, -- Sets gpd, gpi, gpr, etc.
		})
	end,
}
