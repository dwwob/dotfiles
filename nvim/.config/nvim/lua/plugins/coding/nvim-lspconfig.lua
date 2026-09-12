-- ~/.config/nvim/lua/plugins/coding/nvim-lspconfig.lua

return {
	"neovim/nvim-lspconfig",
	lazy = false,
	priority = 900,
	dependencies = {
		"williamboman/mason.nvim",
		"mason-org/mason-lspconfig.nvim", -- 🚀 CRITICAL BRIDGE TO AUTOMATE 0.12+ AUTOSTART
		"saghen/blink.cmp",
	},
	config = function()
		-- 1. Create a modern LspAttach autocommand to handle keymaps natively
		local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
		vim.api.nvim_create_autocmd("LspAttach", {
			group = lsp_group,
			callback = function(args)
				local bufnr = args.buf
				local opts = { buffer = bufnr, silent = true }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
			end,
		})

		-- 2. Fetch blink.cmp's optimized native completion capabilities
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- 3. Apply global capabilities to all servers natively via the 0.12 wildcard
		vim.lsp.config("*", { capabilities = capabilities })

		-- 4. Inject specific configuration profiles BEFORE auto-enable maps them
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { checkThirdParty = false },
				},
			},
		})

		-- Configures self-closing formatting templates for web files natively
		vim.lsp.config("emmet_ls", {
			filetypes = { "html", "css", "sass", "scss", "less", "javascript" },
			init_options = {
				html = { options = { ["output.selfClosingStyle"] = "xhtml" } },
			},
		})

		-- 5. 🚀 INITIALIZE THE MASON BRIDGE LAYER
		-- This automatically reads what you installed inside your :Mason window,
		-- appends the binary execution paths, and fires native autostarts safely!
		require("mason-lspconfig").setup({
			-- Exclude angularls here so it can never trigger background console spams
			automatic_enable = {
				exclude = { "angularls" },
			},
		})
	end,
}

-- -- -- ~/.dotfiles/nvim/.config/nvim/lua/plugins/coding/nvim-lspconfig.lua
-- -- ~/.config/nvim/lua/plugins/coding/nvim-lspconfig.lua
--
-- return {
-- 	"neovim/nvim-lspconfig",
-- 	lazy = false,
-- 	priority = 900,
-- 	dependencies = {
-- 		"williamboman/mason.nvim",
-- 		"saghen/blink.cmp",
-- 	},
-- 	config = function()
-- 		-- 1. Create a modern LspAttach autocommand to handle keymaps natively
-- 		local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
-- 		vim.api.nvim_create_autocmd("LspAttach", {
-- 			group = lsp_group,
-- 			callback = function(args)
-- 				local bufnr = args.buf
-- 				local opts = { buffer = bufnr, silent = true }
--
-- 				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
-- 				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
-- 				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
-- 				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
-- 				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
-- 				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
-- 				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
-- 			end,
-- 		})
--
-- 		-- 2. Fetch blink.cmp's optimized native completion capabilities
-- 		local capabilities = require("blink.cmp").get_lsp_capabilities()
--
-- 		-- 3. Define the language servers you use day-to-day
-- 		local active_servers = { "clangd", "pyright", "lua_ls", "emmet_ls" }
--
-- 		-- 4. Pass options using the native Neovim 0.12 API
-- 		vim.lsp.config("*", { capabilities = capabilities })
--
-- 		-- Apply custom workspace settings for Lua
-- 		vim.lsp.config("lua_ls", {
-- 			settings = {
-- 				Lua = {
-- 					diagnostics = { globals = { "vim" } },
-- 					workspace = { checkThirdParty = false },
-- 				},
-- 			},
-- 		})
--
-- 		-- 🚀 FIX: Pass specific initialization options to emmet_ls to format tags correctly
-- 		vim.lsp.config("emmet_ls", {
-- 			filetypes = { "html", "css", "sass", "scss", "less", "javascript" },
-- 			init_options = {
-- 				html = {
-- 					options = {
-- 						-- Forces modern self-closing markup templates natively
-- 						["output.selfClosingStyle"] = "xhtml",
-- 					},
-- 				},
-- 			},
-- 		})
--
-- 		-- 5. Trigger autostart smoothly
-- 		vim.lsp.enable(active_servers)
-- 	end,
-- }
--
-- return {
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		-- FIXED: Listen to active document buffer triggers cleanly
-- 		event = { "BufReadPre", "BufNewFile" },
-- 		dependencies = { "williamboman/mason-lspconfig.nvim" },
--
-- 		-- FIXED: Embedded keys table here so lazy maps shortcuts to the setup block natively
-- 		keys = {
-- 			{
-- 				"<leader>gpd",
-- 				"<cmd>botright split | lua vim.lsp.buf.definition()<cr>",
-- 				desc = "Definition at Bottom",
-- 			},
-- 			{
-- 				"<leader>gpr",
-- 				"<cmd>botright split | lua vim.lsp.buf.references()<cr>",
-- 				desc = "References at Bottom",
-- 			},
-- 		},
--
-- 		config = function()
-- 			-- Connect blink capabilities globally to Neovim's default LSP pipeline
-- 			local capabilities = require("blink.cmp").get_lsp_capabilities()
--
-- 			require("mason-lspconfig").setup({
-- 				ensure_installed = { "lua_ls", "ts_ls", "html", "emmet_ls", "clangd" },
-- 			})
--
-- 			local servers = { "lua_ls", "ts_ls", "html", "emmet_ls", "clangd" }
-- 			for _, server in ipairs(servers) do
-- 				local server_opts = {
-- 					capabilities = capabilities,
-- 					single_file_support = true, -- Forces LSP attachment on casual standalone files
-- 				}
--
-- 				-- Provide filetype filters for the native 0.12+ config router
-- 				if server == "html" then
-- 					server_opts.filetypes = { "html", "xhtml", "htmldart", "templ" }
-- 					server_opts.init_options = {
-- 						provideFormatter = true,
-- 						embeddedLanguages = { css = true, javascript = true },
-- 						configurationSection = { "html", "css", "javascript" },
-- 					}
-- 				end
--
-- 				-- Explicitly map the trigger extensions for the emmet_ls language binary
-- 				if server == "emmet_ls" then
-- 					server_opts.filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue" }
-- 				end
--
-- 				-- Explicitly tell lua_ls to attach to Lua files natively
-- 				if server == "lua_ls" then
-- 					server_opts.filetypes = { "lua" }
-- 				end
--
-- 				-- Explicitly tell ts_ls to attach to JS/TS files natively
-- 				if server == "ts_ls" then
-- 					server_opts.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
-- 				end
--
-- 				-- Initialize and enable natively using core Neovim 12.3+ mechanisms
-- 				vim.lsp.config(server, server_opts)
-- 				vim.lsp.enable(server)
-- 			end
-- 		end,
-- 	},
-- }
