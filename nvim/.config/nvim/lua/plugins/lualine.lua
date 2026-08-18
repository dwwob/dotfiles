-- 	"nvim-lualine/lualine.nvim",

-- return {
-- 	{
-- 		"nvim-lualine/lualine.nvim",
-- 		dependencies = { "nvim-tree/nvim-web-devicons" },
-- 		event = "VeryLazy", -- Optimizes startup time by delaying loading slightly
-- 		opts = {
-- 			options = {
-- 				theme = "tokyonight", -- Seamless blend with your main theme
-- 				component_separators = { left = "｜", right = "｜" },
-- 				section_separators = { left = "", right = "" },
-- 			},
-- 		},
-- 	},
-- }
--
return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			options = {
				theme = "tokyonight", -- Blends seamlessly with your storm theme
				component_separators = { left = "｜", right = "｜" },
				section_separators = { left = "", right = "" },
				globalstatus = true, -- Keep one single statusline at the bottom if using splits
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = {
					{ "branch", icon = "" },
					{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
				},
				lualine_c = {
					{ "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
					{ "filename", path = 1 }, -- 1 shows relative path so you know exactly where you are
				},
				lualine_x = {
					{ "searchcount", maxcount = 999, timeout = 500 }, -- Shows position in search results (e.g. 2/12)
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		},
	},
}
--
