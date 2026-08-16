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

-- -- ~/.config/nvim/lua/plugins/lsp.lua
-- return {
--   "neovim/nvim-lspconfig",
--   dependencies = { "saghen/blink.cmp" },
--   config = function()
--     local capabilities = require("blink.cmp").get_lsp_capabilities()
--
--     -- 1. Configure and Enable Emmet LS using the v0.12+ engine
--     vim.lsp.config("emmet_ls", { capabilities = capabilities })
--     vim.lsp.enable("emmet_ls")
--
--     -- 2. Define Modern LSP Keymaps via an Autocommand Trigger
--     vim.api.nvim_create_autocmd("LspAttach", {
--       group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
--       callback = function(event)
--         -- Helper function to map keys quickly inside the active LSP buffer
--         local map = function(keys, func, desc)
--           vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
--         end
--
--         -- Core Navigation & Action Keybindings
--         map("gd", vim.lsp.buf.definition, "Go to Definition")
--         map("gD", vim.lsp.buf.declaration, "Go to Declaration")
--         map("gr", vim.lsp.buf.references, "Show References")
--         map("gi", vim.lsp.buf.implementation, "Go to Implementation")
--         map("K", vim.lsp.buf.hover, "Hover Documentation")
--         map("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
--         map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
--
--         -- Diagnostics Navigation (Errors/Warnings)
--         map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
--         map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
--         map("<leader>e", vim.diagnostic.open_float, "Open Floating Diagnostics")
--       end,
--     })
--   end,
-- }
--

-- -- ~/.config/nvim/lua/plugins/lsp.lua
-- return {
--   "neovim/nvim-lspconfig",
--   dependencies = { "saghen/blink.cmp" },
--   config = function()
--     -- Get capabilities from blink.cmp natively
--     local capabilities = require("blink.cmp").get_lsp_capabilities()
--
--     -- 1. Modify the default Emmet config profile with Blink's capabilities
--     vim.lsp.config("emmet_ls", {
--       capabilities = capabilities,
--       -- You can also optionally override default filetypes here if needed:
--       -- filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue", "svelte" },
--     })
--
--     -- 2. Formally enable the language server so Neovim attaches it to buffers
--     vim.lsp.enable("emmet_ls")
--
--     -- Example: How you would add another server (e.g., lua_ls) moving forward
--     -- vim.lsp.config("lua_ls", { capabilities = capabilities })
--     -- vim.lsp.enable("lua_ls")
--   end,
-- }
--

-- -- ~/.config/nvim/lua/plugins/lsp.lua
-- return {
--   "neovim/nvim-lspconfig",
--   dependencies = { "saghen/blink.cmp" },
--   config = function()
--     local lspconfig = require("lspconfig")
--     local capabilities = require("blink.cmp").get_lsp_capabilities()
--
--     -- Attach Emmet LS
--     lspconfig.emmet_ls.setup({
--       capabilities = capabilities,
--       filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue", "svelte" },
--     })
--   end,
-- }

-- return {
--   {
--     "neovim/nvim-lspconfig",
--     event = { "BufReadPre", "BufNewFile" },
--     config = function()
--       -- Establish default visual mapping shortcuts when any server mounts
--       vim.api.nvim_create_autocmd("LspAttach", {
--         callback = function(event)
--           local map = function(keys, func, desc)
--             vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
--           end
--           map("gd", vim.lsp.buf.definition, "Go to Definition")
--           map("K", vim.lsp.buf.hover, "Hover Documentation")
--           map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
--         end,
--       })
--
--       -- Direct native registration: No wrappers, no loops, zero failure conditions
--       vim.lsp.enable("html")
--       vim.lsp.enable("ts_ls")
--       vim.lsp.enable("cssls")
--     end,
--   }
-- }
--
