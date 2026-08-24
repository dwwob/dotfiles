-- ~/.config/nvim/lua/plugins/coding.lua
return {
	-- =========================================================================
	-- 1. MASON & MODERN NATIVE LSP CONFIGURATION (PURE NEOVIM 0.12+ COMPLIANT)
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
			-- Connect blink.cmp capabilities globally to Neovim's default LSP pipeline
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "html", "emmet_ls", "clangd" },
			})

			local servers = { "lua_ls", "ts_ls", "html", "emmet_ls", "clangd" }
			for _, server in ipairs(servers) do
				local server_opts = {
					capabilities = capabilities,
					single_file_support = true, -- Forces LSP attachment on casual standalone files
				}

				-- FIXED: Explicitly provide filetype filters for the native 0.12+ config router
				if server == "html" then
					server_opts.filetypes = { "html", "xhtml", "htmldart", "templ" }
					server_opts.init_options = {
						provideFormatter = true,
						embeddedLanguages = { css = true, javascript = true },
						configurationSection = { "html", "css", "javascript" },
					}
				end

				-- FIXED: Explicitly map the trigger extensions for the emmet_ls language binary
				if server == "emmet_ls" then
					server_opts.filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue" }
				end

				-- FIXED: Explicitly tell lua_ls to attach to Lua files natively
				if server == "lua_ls" then
					server_opts.filetypes = { "lua" }
				end

				-- FIXED: Explicitly tell ts_ls to attach to JS/TS files natively
				if server == "ts_ls" then
					server_opts.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
				end

				-- Initialize and enable natively using core Neovim 12.3+ mechanisms
				vim.lsp.config(server, server_opts)
				vim.lsp.enable(server)
			end
		end,
	},

	-- =========================================================================
	-- 2. BLINK.CMP (UP-TO-DATE LAYOUT STRUCTURE + SNIPPET PREVIEWERS)
	-- =========================================================================
	{
		"saghen/blink.cmp",
		version = "1.*",
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
			snippets = {
				preset = "default",
			},
			completion = {
				keyword = { range = "full" },
				trigger = { show_on_insert_on_trigger_character = true },

				-- Anchors a dynamic snippet preview panel on the right side of the menu
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
	-- 3. PAIRS & CLOSES (AUTOPAIRS ONLY - NO MAPPING INTERFERENCES)
	-- =========================================================================
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({
				disable_filetype = { "TelescopePrompt" },
				check_ts = true, -- Integrates with Treesitter scopes cleanly
			})
		end,
	},

	-- =========================================================================
	-- 4. LEGACY EMMET-VIM (CLASSIC EXPANSION TRIGGERS)
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
	-- 6. MINI UTILITIES
	-- =========================================================================
	{
		"echasnovski/mini.nvim",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.ai").setup()
			require("mini.surround").setup()
			require("mini.cmdline").setup()
		end,
	},
}
