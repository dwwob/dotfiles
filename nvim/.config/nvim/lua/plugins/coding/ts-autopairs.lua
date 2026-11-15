-- ~/.config/nvim/lua/plugins/ts-autopairs.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- treesitter.lua, nvim-lspconfig.lua, lsp_signature.lua,
-- goto-preview.lua, emmet_vim.lua, mason.lua, conform.lua,
-- blink.lua, init.lua, lazy.lua, auto.lua, keybinds.lua, and
-- options.lua, and the spec kept together under its own header.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits directly in lua/plugins/ (not in coding/),
--     so it is covered by the "plugins" import itself.
--   * Lazy loading: event = "InsertEnter" means lazy.nvim loads
--     this plugin when you first enter Insert mode, not at
--     startup.
--   * Not the same plugin as nvim-ts-autotag. treesitter.lua
--     sets up windwp/nvim-ts-autotag, which auto-closes HTML /
--     XML tags. This file is windwp/nvim-autopairs, which pairs
--     brackets and quotes as you type. Same author, different
--     plugins -- no duplicate, and no setup call is repeated.
--   * Treesitter link lines up: check_ts = true below uses
--     treesitter to decide where not to pair, and ts_config
--     names lua "string" and javascript "template_string"
--     nodes. treesitter.lua's ensure_installed list includes
--     both lua and javascript, so those parsers are there for
--     this check to use.
--   * Watch out with blink.lua: blink.lua has
--     completion.accept.auto_brackets enabled, so accepting a
--     completion can add a closing bracket. That acts on
--     completion accept, while nvim-autopairs acts on brackets
--     and quotes you type yourself, so they do not double-pair
--     on ordinary typing -- but they are two separate systems
--     adding closing brackets in the same buffers, so if you
--     ever see a doubled closing bracket after accepting a
--     completion, this overlap is the first place to look.
--     Left as-is.
--   * No double pairing from keybinds.lua today: keybinds.lua
--     still has that unfinished auto-pairing section at the
--     end (is_text_file() / bracket_pairs). Nothing uses those
--     two yet, so they add no pairing at all. If you finish
--     that section later, it would be a third pairing system
--     alongside this plugin and blink's auto_brackets, and
--     the three could double-pair. Left as-is.
--   * No keymaps are defined in this file itself, so nothing
--     here clashes with keybinds.lua, nvim-lspconfig.lua's
--     LspAttach keymaps, or goto-preview.lua. The pairing is
--     handled by the plugin in Insert mode.
--   * No autocmds or save hooks here of its own, so nothing
--     overlaps auto.lua's BufWritePost compile-and-run or
--     conform.lua's BufWritePre format on save. Its only event
--     is the lazy.nvim loading event, InsertEnter.

-- ---------------------------------------------------------------------------
-- Nvim-Autopairs
-- ---------------------------------------------------------------------------
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true, -- Enable Treesitter integration
			ts_config = {
				lua = { "string" }, -- Ignore string nodes in Lua
				javascript = { "template_string" },
			},
		})
	end,
}
