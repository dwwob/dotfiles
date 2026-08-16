return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = {}, -- This forces a safe fallback configuration
	},
}

-- return {
-- 	{
-- 		"williamboman/mason.nvim",
-- 		-- ONLY pull nvim-lspconfig as a pure data repository for server configs
-- 		dependencies = { "neovim/nvim-lspconfig" },
-- 		config = function()
-- 			-- Initialize mason safely without any extra automation hooks
-- 			require("mason").setup()
--
-- 			-- Tell Neovim to immediately assign global keymaps whenever an LSP binds
-- 			vim.api.nvim_create_autocmd("LspAttach", {
-- 				callback = function(event)
-- 					local map = function(keys, func, desc)
-- 						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
-- 					end
-- 					map("gd", vim.lsp.buf.definition, "Go to Definition")
-- 					map("K", vim.lsp.buf.hover, "Hover Documentation")
-- 					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
-- 				end,
-- 			})
--
-- 			-- List the servers you intend to use
-- 			local servers = { "html", "ts_ls", "cssls" }
--
-- 			-- Use native Neovim 0.12 API to safely activate each language server
-- 			for _, server in ipairs(servers) do
-- 				if vim.lsp.config(server) then
-- 					vim.lsp.enable(server)
-- 				end
-- 			end
-- 		end,
-- 	},
-- }
--
-- return {
-- 	{
-- 		"williamboman/mason.nvim",
-- 		dependencies = { "neovim/nvim-lspconfig" }, -- Data provider for native layouts
-- 		config = function()
-- 			require("mason").setup()
--
-- 			-- Setup global buffer keymaps for when any LSP client attaches
-- 			vim.api.nvim_create_autocmd("LspAttach", {
-- 				callback = function(event)
-- 					local map = function(keys, func, desc)
-- 						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
-- 					end
-- 					map("gd", vim.lsp.buf.definition, "Go to Definition")
-- 					map("K", vim.lsp.buf.hover, "Hover Documentation")
-- 					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
-- 				end,
-- 			})
--
-- 			-- Safely enable your preferred servers using the native API
-- 			local servers = { "html", "ts_ls", "cssls" }
-- 			for _, server in ipairs(servers) do
-- 				if vim.lsp.config(server) then
-- 					vim.lsp.enable(server)
-- 				end
-- 			end
-- 		end,
-- 	},
-- }
