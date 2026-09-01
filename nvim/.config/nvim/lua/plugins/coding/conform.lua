-- =========================================================================
-- 5. FORMATTING & LINTING
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
