-- ~/.config/nvim/lua/plugins/coding.lua
return {
	-- =========================================================================
	-- 1. MASON & NATIVE LSP CONFIGURATION (NEOVIM 0.12+ SPECIFIC)
	-- =========================================================================
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "html", "emmet_language_server" },
			})

			local servers = { "lua_ls", "ts_ls", "html", "emmet_language_server" }
			for _, server in ipairs(servers) do
				vim.lsp.config(server, {
					capabilities = capabilities,
				})
				vim.lsp.enable(server)
			end
		end,
	},

	-- =========================================================================
	-- 2. BLINK.CMP (COMPLETION ENGINE) + FRIENDLY-SNIPPETS
	-- =========================================================================
	{
		"saghen/blink.cmp",
		version = "v0.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			snippets = {
				preset = "default",
			},
			completion = {
				keyword = { range = "full" },
				trigger = { show_on_insert_on_trigger_character = true },
			},
		},
		config = function(_, opts)
			require("blink.cmp").setup(opts)
		end,
	},

	-- =========================================================================
	-- 3. PAIRS & CLOSES (FIXED: AUTOCLOSE REMOVED TO PREVENT TAG INTERFERENCE)
	-- =========================================================================
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({
				-- Disable autopairs specifically for standard HTML angle brackets
				-- so that nvim-ts-autotag can handle them cleanly
				disable_filetype = { "TelescopePrompt" },
				check_ts = true,
			})
		end,
	},

	-- =========================================================================
	-- 4. FORMATTING & LINTING
	-- =========================================================================
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				html = { "prettier" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("lint").linters_by_ft = {}
		end,
	},

	-- =========================================================================
	-- 5. MINI UTILITIES
	-- =========================================================================
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.ai").setup()
			require("mini.surround").setup()
		end,
	},
}
