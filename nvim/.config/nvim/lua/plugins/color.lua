-- ~/.config/nvim/lua/
return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- Load immediately on startup
		priority = 1000, -- Load before all other plugins
		config = function()
			require("tokyonight").setup({
				style = "moon", -- Max color saturation
				transparent = false,
				styles = {
					comments = { italic = true },
					keywords = { italic = true, bold = true },
					functions = { bold = true },
				},
				on_highlights = function(hl, c)
					-- 1. Vibrantly bright Cyan Comments
					hl.Comment = { fg = "#c2d6d6", italic = true }

					-- 2. Neon Yellow Active Line Number
					hl.CursorLineNr = { fg = "#ffca28", bold = true }

					-- 3. ENHANCED: Sharp, high-contrast silver/ice-blue for inactive line numbers
					hl.LineNr = { fg = "#0000ff" }
					hl.LineNrAbove = { fg = "#0000ff" }
					hl.LineNrBelow = { fg = "#0000ff" }

					-- 4. Dynamic background pop for selecting text
					hl.Visual = { bg = "#3b4261", bold = true }
				end,
			})

			-- Execute the color application
			vim.cmd.colorscheme("tokyonight-moon")
		end,
	},
}
