-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
	-- =========================================================================
	-- 1. NVIM-TREESITTER (CODE PARSING & HIGHLIGHTS)
	-- =========================================================================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter").setup({
				-- Ensure html and xml parsers are explicitly loaded for tag scanning
				ensure_installed = { "lua", "vim", "vimdoc", "html", "xml", "css", "javascript", "typescript" },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
			})

			-- Code Formatter on Save Trigger Hook
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.html", "*.lua", "*.js", "*.ts" },
				callback = function(args)
					require("conform").format({ bufnr = args.buf, lsp_fallback = true })
				end,
			})
		end,
	},

	-- =========================================================================
	-- 2. TS-AUTOTAG.NVIM (FIXED INITIALIZATION OVERRIDES)
	-- =========================================================================
	{
		"windwp/nvim-ts-autotag",
		lazy = false, -- CRITICAL FIXED: Must not be lazy-loaded
		priority = 1000, -- CRITICAL FIXED: Force immediate hook attachment
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto close tags when typing >
					enable_rename = true, -- Auto rename matching pairs
					enable_close_on_slash = true, -- Auto close on trailing slash
				},
			})
		end,
	},

	-- =========================================================================
	-- 3. TS-COMMENTS.NVIM
	-- =========================================================================
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- =========================================================================
	-- 4. LSP SIGNATURE FLOATING HELPER
	-- =========================================================================
	{
		"ray-x/lsp_signature.nvim",
		event = "LspAttach",
		opts = {
			bind = true,
			handler_opts = { border = "rounded" },
		},
	},
}
