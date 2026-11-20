-- ~/.dotfiles/nvim/.config/nvim/lua/plugins/coding/blink.lua
--
-- Cleaned-up version of original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- init.lua, lazy.lua, auto.lua, keybinds.lua, and options.lua, and
-- each group kept together under its own header. The two "THE FIX"
-- comments are kept, in plain wording.
--

return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {
		-- -----------------------------------------------------------
		-- Appearance
		-- -----------------------------------------------------------
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},

		-- -----------------------------------------------------------
		-- Completion
		-- -----------------------------------------------------------
		completion = {
			accept = { auto_brackets = { enabled = true } },

			keyword = { range = "full" },

			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},

			-- Unlock the preview layer window for snippets
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 50,
				window = {
					border = "rounded",
				},
			},

			ghost_text = { enabled = true },
		},

		-- -----------------------------------------------------------
		-- Snippets
		-- -----------------------------------------------------------
		-- Use Neovim 0.12.5 native structural snippet engine
		snippets = {
			preset = "default",
		},

		-- -----------------------------------------------------------
		-- Keymap
		-- -----------------------------------------------------------
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},

		-- -----------------------------------------------------------
		-- Sources
		-- -----------------------------------------------------------
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },

			-- Instruct the provider to forcefully allow
			-- documentation previews
			providers = {
				snippets = {
					name = "Snippets",
					module = "blink.cmp.sources.snippets",
					score_offset = 85,
					-- Force blink to always parse and draw snippet
					-- bodies inside the preview panel
					opts = {
						friendly_snippets = true,
					},
				},
			},
		},
	},
}
