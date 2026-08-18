-- ~/.config/nvim/lua/plugins/lsp.lua

return {
	-- 1. Main Completion Engine
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		opts = {
			keymap = { preset = "default" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
	},

	-- 2. Modern Native LSP Setup (Neovim 0.11 / 0.12+)
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp", -- Ensure blink sets up capabilities early
		},
		config = function()
			-- Automatically initialize Mason
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "emmet_language_server", "html" },
			})

			-- Get capabilities from blink.cmp
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Configure HTML natively using vim.lsp.config
			vim.lsp.config("html", {
				capabilities = capabilities,
			})

			-- Configure Emmet natively using vim.lsp.config
			vim.lsp.config("emmet_language_server", {
				capabilities = capabilities,
				filetypes = { "html", "css", "scss" },
				init_options = {
					-- Hands Emmet abbreviations to Blink as expandable snippet options
					showSuggestionsAsSnippets = true,
				},
			})

			-- Automatically enable the configured servers globally
			vim.lsp.enable("html")
			vim.lsp.enable("emmet_language_server")
		end,
	},
}
