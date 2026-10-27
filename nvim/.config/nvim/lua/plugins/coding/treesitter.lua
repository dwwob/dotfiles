-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
	-- =========================================================================
	-- 1. NVIM-TREESITTER (CODE PARSING & HIGHLIGHTS)
	-- =========================================================================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"windwp/nvim-ts-autotag", -- Seamlessly hooks into treesitter parsers
		},
		-- FIX: Pass configuration preferences directly via standard lazy opts table
		opts = {
			ensure_installed = { "bash", "lua", "vim", "vimdoc", "html", "xml", "css", "javascript", "typescript" },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		},
		config = function(_, opts)
			-- FIX: Use the primary module setup entry point instead of the broken .configs submodule
			require("nvim-treesitter").setup(opts)

			-- Initialize the autotag engine cleanly
			require("nvim-ts-autotag").setup()

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
