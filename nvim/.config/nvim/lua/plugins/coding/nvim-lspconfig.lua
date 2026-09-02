-- return {
-- 	"neovim/nvim-lspconfig",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	dependencies = { "williamboman/mason-lspconfig.nvim" },
-- 	config = function()
-- 		local capabilities = require("blink.cmp").get_lsp_capabilities()
--
-- 		require("mason-lspconfig").setup({
-- 			ensure_installed = { "lua_ls", "ts_ls", "html", "emmet_ls", "clangd" },
-- 		})
--
-- 		local servers = { "lua_ls", "ts_ls", "html", "emmet_ls", "clangd" }
-- 		for _, server in ipairs(servers) do
-- 			local server_opts = {
-- 				capabilities = capabilities,
-- 				single_file_support = true,
-- 			}
--
-- 			if server == "html" then
-- 				server_opts.filetypes = { "html", "xhtml", "htmldart", "templ" }
-- 				server_opts.init_options = {
-- 					provideFormatter = true,
-- 					embeddedLanguages = { css = true, javascript = true },
-- 					configurationSection = { "html", "css", "javascript" },
-- 				}
-- 			end
--
-- 			if server == "emmet_ls" then
-- 				server_opts.filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue" }
-- 			end
--
-- 			if server == "lua_ls" then
-- 				server_opts.filetypes = { "lua" }
-- 			end
-- 			if server == "ts_ls" then
-- 				server_opts.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
-- 			end
--
-- 			vim.lsp.config(server, server_opts)
-- 			vim.lsp.enable(server)
-- 		end
-- 	end,
-- }
--
--
--
--
-- lua/plugins/coding/nvim-lspconfig.lua
return {
	{
		"neovim/nvim-lspconfig",
		-- FIXED: Listen to active document buffer triggers cleanly
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },

		-- FIXED: Embedded keys table here so lazy maps shortcuts to the setup block natively
		keys = {
			{
				"<leader>gpd",
				"<cmd>botright split | lua vim.lsp.buf.definition()<cr>",
				desc = "Definition at Bottom",
			},
			{
				"<leader>gpr",
				"<cmd>botright split | lua vim.lsp.buf.references()<cr>",
				desc = "References at Bottom",
			},
		},

		config = function()
			-- Connect blink capabilities globally to Neovim's default LSP pipeline
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

				-- Provide filetype filters for the native 0.12+ config router
				if server == "html" then
					server_opts.filetypes = { "html", "xhtml", "htmldart", "templ" }
					server_opts.init_options = {
						provideFormatter = true,
						embeddedLanguages = { css = true, javascript = true },
						configurationSection = { "html", "css", "javascript" },
					}
				end

				-- Explicitly map the trigger extensions for the emmet_ls language binary
				if server == "emmet_ls" then
					server_opts.filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue" }
				end

				-- Explicitly tell lua_ls to attach to Lua files natively
				if server == "lua_ls" then
					server_opts.filetypes = { "lua" }
				end

				-- Explicitly tell ts_ls to attach to JS/TS files natively
				if server == "ts_ls" then
					server_opts.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
				end

				-- Initialize and enable natively using core Neovim 12.3+ mechanisms
				vim.lsp.config(server, server_opts)
				vim.lsp.enable(server)
			end
		end,
	},
}
