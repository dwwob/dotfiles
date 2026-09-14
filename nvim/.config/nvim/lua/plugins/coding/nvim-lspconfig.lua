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
