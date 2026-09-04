-- =========================================================================
-- 1. COLOR.LUA & VIVID DARK THEME OVERRIDES
-- =========================================================================
return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night", -- High-vibrancy dark base style
			transparent = true, -- Enable beautiful transparent background
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		})
		vim.cmd([[colorscheme tokyonight]])

		-- VIVID COLOR DEFINITIONS: Force maximum contrast and high-visibility
		local vivid_neon_blue = "#00f0ff"
		local vivid_neon_pink = "#ff007f"
		local vivid_gunmetal_gray = "#8D918D"
		-- local bright_white = "#ffffff"
		local highly_visible_gray = "#8996db"

		-- 1a. LINE NUMBERS (Active vs. Relative Inactive Stack)
		vim.api.nvim_set_hl(0, "LineNr", { fg = vivid_neon_blue, bold = true }) -- Active line number
		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = highly_visible_gray, bold = false }) -- Stack numbers above
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = highly_visible_gray, bold = false }) -- Stack numbers below

		-- 1b. HIGH-VISIBILITY HTML TAGS & WEB CODE ELEMENTS
		vim.api.nvim_set_hl(0, "htmlTag", { fg = vivid_neon_pink, bold = true }) -- HTML angle brackets
		vim.api.nvim_set_hl(0, "htmlTagName", { fg = vivid_neon_pink, bold = true }) -- HTML structural tag names
		vim.api.nvim_set_hl(0, "htmlArg", { fg = vivid_neon_blue, italic = true }) -- HTML class/id attributes

		-- 1c. HIGH-VISIBILITY COMMENTS (Forces glowing neon green text blocks)
		vim.api.nvim_set_hl(0, "Comment", { fg = vivid_gunmetal_gray, bold = true, italic = true })
		vim.api.nvim_set_hl(0, "htmlComment", { fg = vivid_gunmetal_gray, bold = true, italic = true })
		vim.api.nvim_set_hl(0, "htmlCommentPart", { fg = vivid_gunmetal_gray, bold = true, italic = true })
	end,
}
