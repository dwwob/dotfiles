-- ~/.dotfiles/nvim/.config/nvim/lua/plugins/coding/conform.lua

-- =========================================================================
-- 5. FORMATTING by file type
-- =========================================================================
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			html = { "prettier" },
		},
	},
}
