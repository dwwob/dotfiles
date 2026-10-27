-- =========================================================================
-- 1. COLOR.LUA & VIVID DARK THEME OVERRIDES
-- =========================================================================
return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "moon", -- High-vibrancy dark base style
			transparent = true, -- Enable beautiful transparent background
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},

			-- VIVID COLOR DEFINITIONS: Force maximum contrast and high-visibility
			on_highlights = function(hl, c)
				local vivid_neon_blue = "#00f0ff"
				local vivid_neon_pink = "#ff007f"
				local vivid_gunmetal_gray = "#8D918D"
				local highly_visible_gray = "#8996db"

				-- 1a. LINE NUMBERS (Active vs. Relative Inactive Stack)
				hl.CursorLineNr = { fg = vivid_neon_blue, bold = true } -- Active center line number
				hl.LineNr = { fg = highly_visible_gray, bold = false } -- Inactive stack lines
				hl.LineNrAbove = { fg = highly_visible_gray, bold = false } -- Stack numbers above
				hl.LineNrBelow = { fg = highly_visible_gray, bold = false } -- Stack numbers below

				-- 1b. HIGH-VISIBILITY HTML TAGS & WEB CODE ELEMENTS
				hl.htmlTag = { fg = vivid_neon_pink, bold = true } -- HTML angle brackets
				hl.htmlTagName = { fg = vivid_neon_pink, bold = true } -- HTML structural tag names
				hl.htmlArg = { fg = vivid_neon_blue, italic = true } -- HTML class/id attributes

				-- 1c. HIGH-VISIBILITY COMMENTS (Forces glowing neon gray text blocks)
				hl.Comment = { fg = vivid_gunmetal_gray, bold = true, italic = true }
				hl.htmlComment = { fg = vivid_gunmetal_gray, bold = true, italic = true }
				hl.htmlCommentPart = { fg = vivid_gunmetal_gray, bold = true, italic = true }
			end,
		})

		-- Safely initialize the theme with overrides active
		vim.cmd([[colorscheme tokyonight]])
	end,
}
