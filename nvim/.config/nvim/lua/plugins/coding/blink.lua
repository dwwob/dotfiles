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

-- --
-- --
-- -- =========================================================================
-- -- 2. BLINK.CMP + NATIVE ENGINE LOAD (FRIENDLY-SNIPPETS PATCHED)
-- -- =========================================================================
-- return {
-- 	"saghen/blink.cmp",
-- 	version = "v0.*",
-- 	dependencies = { "rafamadriz/friendly-snippets" },
-- 	opts = {
-- 		keymap = {
-- 			preset = "default",
-- 			["<CR>"] = { "accept", "fallback" },
-- 			["<C-b>"] = { "scroll_documentation_up", "fallback" },
-- 			["<C-f>"] = { "scroll_documentation_down", "fallback" },
-- 		},
-- 		appearance = { nerd_font_variant = "mono" },
-- 		sources = { default = { "lsp", "path", "snippets", "buffer" } },
-- 		cmdline = {
-- 			sources = function()
-- 				local type = vim.fn.getcmdtype()
-- 				if type == "/" or type == "?" then
-- 					return { "buffer" }
-- 				end
-- 				if type == ":" then
-- 					return { "cmdline" }
-- 				end
-- 				return {}
-- 			end,
-- 		},
-- 		-- Configures blink to expand text blocks natively via Neovim
-- 		snippets = { preset = "default" },
-- 		completion = {
-- 			keyword = { range = "full" },
-- 			trigger = { show_on_insert_on_trigger_character = true },
--
-- 			-- Flyout preview panel showing what the snippet contains before executing
-- 			documentation = {
-- 				auto_show = true,
-- 				auto_show_delay_ms = 50,
-- 				window = { border = "rounded" },
-- 			},
--
-- 			menu = {
-- 				draw = {
-- 					columns = {
-- 						{ "label", "label_description", gap = 1 },
-- 						{ "kind_icon", "kind", gap = 1 },
-- 					},
-- 				},
-- 			},
-- 		},
-- 	},
-- 	-- ADDED SNIPPET LOADER ROUTINE:
-- 	config = function(_, opts)
-- 		require("blink.cmp").setup(opts)
-- 		-- FIXED: Points Neovim's native runtime to your downloaded snippet framework
-- 		vim.g.vscode_snippets_path = vim.fn.stdpath("data") .. "/lazy/friendly-snippets"
-- 	end,
-- }
