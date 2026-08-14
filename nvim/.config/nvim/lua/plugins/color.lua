return {
	-- Colorscheme Configuration
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "storm", -- Choose: storm, moon, night, or day
			on_highlights = function(hl, c)
				-- Make line numbers and sign column highly visible
				hl.LineNr = { fg = c.comment, bg = c.bg_statusline }
				hl.CursorLineNr = { fg = c.orange, bold = true }
				hl.SignColumn = { bg = c.bg_statusline }

				-- Make relative numbers brighter than standard comments
				hl.LineNrAbove = { fg = c.blue2 }
				hl.LineNrBelow = { fg = c.blue2 }
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	-- Statusline Configuration
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "tokyonight", -- Automatically syncs with tokyonight theme
				globalstatus = true,
			},
		},
	},
}
