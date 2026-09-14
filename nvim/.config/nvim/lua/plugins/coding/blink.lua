-- -- ~/.dotfiles/nvim/.config/nvim/lua/plugins/coding/blink.lua

-- ~/.config/nvim/lua/plugins/coding/blink.lua

return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},

		completion = {
			accept = { auto_brackets = { enabled = true } },

			keyword = { range = "full" },

			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},

			-- 🚀 THE FIX: UNLOCK THE PREVIEW LAYER WINDOW FOR SNIPPETS
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 50,
				window = {
					border = "rounded",
				},
			},

			ghost_text = { enabled = true },
		},

		-- Use Neovim 0.12.5 native structural snippet engine
		snippets = {
			preset = "default",
		},

		keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },

			-- 🚀 THE FIX: Instruct the provider to forcefully allow documentation previews
			providers = {
				snippets = {
					name = "Snippets",
					module = "blink.cmp.sources.snippets",
					score_offset = 85,
					-- Force blink to always parse and draw snippet bodies inside the preview panel
					opts = {
						friendly_snippets = true,
						search_paths = {},
					},
				},
			},
		},
	},
}
