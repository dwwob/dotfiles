	return {
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "html", "emmet_ls", "clangd" },
			})

			local servers = { "lua_ls", "ts_ls", "html", "emmet_ls", "clangd" }
			for _, server in ipairs(servers) do
				local server_opts = {
					capabilities = capabilities,
					single_file_support = true,
				}

				if server == "html" then
					server_opts.filetypes = { "html", "xhtml", "htmldart", "templ" }
					server_opts.init_options = {
						provideFormatter = true,
						embeddedLanguages = { css = true, javascript = true },
						configurationSection = { "html", "css", "javascript" },
					}
				end

				if server == "emmet_ls" then
					server_opts.filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue" }
				end

				if server == "lua_ls" then
					server_opts.filetypes = { "lua" }
				end
				if server == "ts_ls" then
					server_opts.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
				end

				vim.lsp.config(server, server_opts)
				vim.lsp.enable(server)
			end
		end,
	}

