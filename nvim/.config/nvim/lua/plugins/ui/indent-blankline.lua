-- ~/.config/nvim/lua/plugins/ui/indent-blankline.lua
--
-- Cleaned-up version of your original file.
-- Every colour and setting is the same as before -- nothing was
-- changed, moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- color.lua, which-key.lua, vim-fugitive.lua, trouble.lua,
-- telescope.lua, inline.lua, nvim-lint.lua, toggleterm.lua,
-- git.lua, ts-autopairs.lua, treesitter.lua, nvim-lspconfig.lua,
-- lsp_signature.lua, goto-preview.lua, emmet_vim.lua, mason.lua,
-- conform.lua, blink.lua, init.lua, lazy.lua, auto.lua,
-- keybinds.lua, and options.lua, and the spec kept together
-- under its own header.
-- The numbered step comments (1. to 4.) are reworded to plain
-- text, and the rocket comment on the highlight hook is removed;
-- the hex colours themselves are kept exactly.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/ui/, so it is covered by
--     the "plugins.ui" import. It loads on event = {
--     "BufReadPost", "BufNewFile" }, not at startup.
--   * main = "ibl" is kept: lazy.nvim uses it to call
--     require("ibl").setup() style loading for this plugin,
--     and the config function below does the full setup itself,
--     including registering the highlight hook before setup.
--   * Colour hook lines up with color.lua: the
--     hooks.type.HIGHLIGHT_SETUP hook re-registers the seven
--     Ibl* highlight groups every time ibl refreshes its
--     highlights (including after a colourscheme change), so
--     the colours below survive color.lua loading
--     tokyonight at startup. The seven hex colours are a
--     fixed palette (#E06C75, #D19A66, #E5C07B, #98C379,
--     #61AFEF, #C678DD, #56B6C2) -- they are not tokyonight
--     colours, they sit alongside it, exactly as in your
--     original. Nothing was recoloured to match tokyonight.
--   * Scope guide uses treesitter when it is available:
--     scope.enabled = true shows the block your cursor is in.
--     treesitter.lua loads nvim-treesitter on the same
--     BufReadPost / BufNewFile events, so the parsers ibl
--     can use for scope are provided by that file. No setting
--     in either file conflicts.
--   * Excluded filetypes are kept exactly: "cobol", "help",
--     "dashboard", "lazy", and "mason" get no indent guides
--     and no scope guide. That means COBOL files (see
--     cobol_snippets.lua / blink.lua) intentionally have no
--     guides, and the lazy and mason windows stay clean.
--   * No keymaps, user commands, or save hooks here of its
--     own, so nothing overlaps conform.lua's format on save,
--     nvim-lint.lua's lint autocmds, auto.lua's
--     compile-and-run, or any <leader> keys from keybinds.lua,
--     telescope.lua, trouble.lua, or which-key.lua.
--   * It does not set any diagnostic, sign, or GitSigns
--     groups, so options.lua's diagnostic signs, git.lua's
--     gitsigns, and inline.lua's diagnostics are untouched.
--
-- ---------------------------------------------------------------------------
-- Indent Blankline (indent guides)
-- ---------------------------------------------------------------------------
return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	main = "ibl", -- Binds directly to modern ibl module setups
	config = function()
		-- Declare the sequential list of colour level groups
		local custom_highlights = {
			"IblRed",
			"IblOrange",
			"IblYellow",
			"IblGreen",
			"IblBlue",
			"IblPurple",
			"IblCyan",
		}

		-- Fetch the ibl hooks engine module wrapper
		local hooks = require("ibl.hooks")

		-- The critical hook: register highlight definitions cleanly.
		-- These hex colours adapt alongside your current Tokyonight layers.
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IblRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "IblOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "IblYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "IblGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "IblBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "IblPurple", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "IblCyan", { fg = "#56B6C2" })
		end)

		-- Execute the primary plugin parameters
		require("ibl").setup({
			-- Passive indent guides (loops your colour spectrum across tabs)
			indent = {
				char = "│",
				highlight = custom_highlights,
			},
			-- Active context scope guide (highlights the block your cursor is on)
			scope = {
				enabled = true,
				char = "▎",
				highlight = { "IblBlue" }, -- Active block indicator locks into sharp blue
			},
			exclude = {
				filetypes = {
					"cobol",
					"help",
					"dashboard",
					"lazy",
					"mason",
				},
			},
		})
	end,
}
