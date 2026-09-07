--  =========================================================================
-- 2. TS-AUTOTAG.NVIM (FIXED INITIALIZATION OVERRIDES)
-- =========================================================================
return {
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
}
