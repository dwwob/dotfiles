-- ~/.config/nvim/lua/plugins/ui.lua
return {
	-- =========================================================================
	-- 1. COLOR.LUA & VIVID DARK THEME OVERRIDES
	-- =========================================================================
	{
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
			})
			vim.cmd([[colorscheme tokyonight]])

			-- VIVID COLOR DEFINITIONS: Force maximum contrast and high-visibility
			local vivid_neon_blue = "#00f0ff"
			local vivid_neon_pink = "#ff007f"
			local vivid_neon_green = "#39ff14"
			local bright_white = "#ffffff"
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
			vim.api.nvim_set_hl(0, "Comment", { fg = vivid_neon_green, bold = true, italic = false })
			vim.api.nvim_set_hl(0, "htmlComment", { fg = vivid_neon_green, bold = true })
			vim.api.nvim_set_hl(0, "htmlCommentPart", { fg = vivid_neon_green, bold = true })
		end,
	},

	-- =========================================================================
	-- 2. NEON-THEMED STATUSLINE (LUALINE WITH CUSTOM COMPONENT COLORING)
	-- =========================================================================
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "tokyonight",
				component_separators = { left = "│", right = "│" },
				section_separators = { left = " ", right = " " },
				disabled_filetypes = { statusline = { "lazy", "mason" } },
			},
			sections = {
				lualine_a = { { "mode", color = { gui = "bold" } } },
				lualine_b = {
					{ "branch", color = { fg = "#ff007f", gui = "bold" } },
					"diff",
					"diagnostics",
				},
				lualine_c = { { "filename", path = 1, color = { fg = "#ffffff" } } },
				lualine_x = {
					{
						function()
							local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
							if #buf_clients == 0 then
								return "No LSP"
							end
							local client_names = {}
							for _, client in ipairs(buf_clients) do
								table.insert(client_names, client.name)
							end
							return "LSP: " .. table.concat(client_names, ", ")
						end,
						icon = "",
						color = { fg = "#00f0ff", gui = "bold" }, -- Vivid neon blue label
					},
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},

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
