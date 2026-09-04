-- ~/.dotfiles/nvim/.config/nvim/lua/plugins/coding/blink.lua
--
--
-- =========================================================================
-- 2. BLINK.CMP + NATIVE ENGINE LOAD (FRIENDLY-SNIPPETS PATCHED)
-- =========================================================================
return {
	"saghen/blink.cmp",
	version = "v0.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {
		keymap = {
			preset = "default",
			["<CR>"] = { "accept", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},
		appearance = { nerd_font_variant = "mono" },
		sources = { default = { "lsp", "path", "snippets", "buffer" } },
		cmdline = {
			sources = function()
				local type = vim.fn.getcmdtype()
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				if type == ":" then
					return { "cmdline" }
				end
				return {}
			end,
		},
		-- Configures blink to expand text blocks natively via Neovim
		snippets = { preset = "default" },
		completion = {
			keyword = { range = "full" },
			trigger = { show_on_insert_on_trigger_character = true },

			-- Flyout preview panel showing what the snippet contains before executing
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 50,
				window = { border = "rounded" },
			},

			menu = {
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
					},
				},
			},
		},
	},
	-- ADDED SNIPPET LOADER ROUTINE:
	config = function(_, opts)
		require("blink.cmp").setup(opts)
		-- FIXED: Points Neovim's native runtime to your downloaded snippet framework
		vim.g.vscode_snippets_path = vim.fn.stdpath("data") .. "/lazy/friendly-snippets"
	end,
}
