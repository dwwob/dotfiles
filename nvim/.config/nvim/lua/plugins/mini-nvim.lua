-- ==========================================================================	-
-- 6. MINI UTILITIES
-- =========================================================================
return {
	"echasnovski/mini.nvim",
	version = false,
	event = "VeryLazy",
	config = function()
		require("mini.ai").setup()
		require("mini.surround").setup()
		require("mini.cmdline").setup()
	end,
}
