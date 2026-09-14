-- ~/.config/nvim/lua/plugins/ui/indent-blankline.lua

return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	main = "ibl", -- Binds directly to modern ibl module setups
	config = function()
		-- 1. Declare the sequential list of color level groups
		local custom_highlights = {
			"IblRed",
			"IblOrange",
			"IblYellow",
			"IblGreen",
			"IblBlue",
			"IblPurple",
			"IblCyan",
		}

		-- 2. Fetch the ibl hooks engine module wrapper
		local hooks = require("ibl.hooks")

		-- 3. 🚀 THE CRITICAL HOOK: Register highlight definitions cleanly!
		-- These Hex colors adapt beautifully alongside your current Tokyonight layers.
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IblRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "IblOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "IblYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "IblGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "IblBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "IblPurple", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "IblCyan", { fg = "#56B6C2" })
		end)

		-- 4. Execute the primary plugin parameters
		require("ibl").setup({
			-- Passive Indent Guides (Loops your color spectrum across tabs)
			indent = {
				char = "│",
				highlight = custom_highlights,
			},
			-- Active Context Scope Guide (Highlights the block your cursor is on)
			scope = {
				enabled = true,
				char = "▎",
				highlight = { "IblBlue" }, -- Active block indicator locks into sharp blue
			},
			exclude = {
				filetypes = {
					"cobol",
					"help",
					"dashboard",
					"lazy",
					"mason",
				},
			},
		})
	end,
}
