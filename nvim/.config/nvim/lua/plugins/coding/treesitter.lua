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
}
