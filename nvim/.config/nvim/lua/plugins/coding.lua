-- ~/.config/nvim/lua/plugins/coding.lua
return {
	-- =========================================================================
	-- 1. MASON & NATIVE LSP CONFIGURATION (WITH C / CLANGD SUPPORT)
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

			-- Automatically download servers including clangd for C development
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "html", "emmet_language_server", "clangd" },
			})

			-- Register and enable servers natively via Neovim 0.12+ API
			local servers = { "lua_ls", "ts_ls", "html", "emmet_language_server", "clangd" }
			for _, server in ipairs(servers) do
				vim.lsp.config(server, {
					capabilities = capabilities,
				})
				vim.lsp.enable(server)
			end
		end,
	},

	-- =========================================================================
	-- 2. BLINK.CMP (COMPLETION ENGINE) + INLINE SNIPPET PREVIEWERS
	-- =========================================================================
	{
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

				-- Anchors a dynamic snippet preview panel on the right side
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
		config = function(_, opts)
			require("blink.cmp").setup(opts)
		end,
	},

	-- =========================================================================
	-- 3. PAIRS & CLOSES (AUTOPAIRS ONLY - NO AUTOCLOSE CONFLICTS)
	-- =========================================================================
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({
				disable_filetype = { "TelescopePrompt" },
				check_ts = true,
			})
		end,
	},

	-- =========================================================================
	-- 4. LEGACY EMMET-VIM (CLASSIC TRIGGERS)
	-- =========================================================================
	{
		"mattn/emmet-vim",
		ft = { "html", "css", "javascriptreact", "typescriptreact", "vue" },
		init = function()
			-- Restores your classic leader sequence trigger key map (<C-y>,)
			vim.g.user_emmet_leader_key = "<C-y>"
			vim.g.user_emmet_mode = "a"
		end,
	},

	-- =========================================================================
	-- 5. FORMATTING & LINTING
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
	-- 6. MINI UTILITIES (CONSOLIDATED WITH CMDLINE)
	-- =========================================================================
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.ai").setup()
			require("mini.surround").setup()
			require("mini.cmdline").setup({})
			require("mini.operators").setup({})
			require("mini.basics").setup({})
			require("mini.extra").setup({})
			require("mini.misc").setup({})
		end,
	},
}
