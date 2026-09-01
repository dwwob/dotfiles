-- =========================================================================
-- 2. NEON-THEMED STATUSLINE (LUALINE WITH CUSTOM COMPONENT COLORING)
-- =========================================================================
return {
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
				"encoding",
				"fileformat",
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
