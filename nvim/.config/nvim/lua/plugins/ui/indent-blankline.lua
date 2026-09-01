return {
	-- =========================================================================
	-- 3. INDENTBLANKLINE.LUA (VIVID SCOPE GUIDE TRACKING)
	-- =========================================================================
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = false,
				highlight = { "Function", "Label" }, -- Highlights active brackets using structural syntax colors
			},
		},
	},
}
