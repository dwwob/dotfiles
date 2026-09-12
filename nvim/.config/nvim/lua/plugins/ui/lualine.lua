-- -- ~/.config/nvim/lua/plugins/ui/statusline.lua
-- ~/.config/nvim/lua/plugins/ui/lualine.lua

-- 🚀 THE MODERN 0.12+ LSP STATUSLINE RESOLVER
local function get_active_lsp()
	-- Uses the new 0.12+ client getter filtered directly to your active buffer (bufnr = 0)
	local buf_clients = vim.lsp.get_clients({ bufnr = 0 })

	if #buf_clients == 0 then
		return "🔇 No LSP"
	end

	local names = {}
	for _, client in ipairs(buf_clients) do
		-- Filter out any diagnostic helper abstractions, showing only your hard binaries
		if client.name ~= "copilot" then
			table.insert(names, client.name)
		end
	end

	return "📡 " .. table.concat(names, "|")
end

-- Pass this function variable directly into your lualine sections grid layout:
return {
	"nvim-lualine/lualine.nvim",
	opts = {
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },

			-- 📂 Left-aligned filename paths
			lualine_c = { { "filename", path = 1, shorting_target = 40 } },

			-- 🚀 RIGHT-ALIGNED COMPONENT: Tracks your running language servers actively!
			lualine_x = { get_active_lsp, "encoding", "fileformat", "filetype" },

			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}

--
-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- 	event = "VeryLazy",
-- 	opts = {
-- 		options = {
-- 			theme = "auto", -- Automatically matches your current active colorscheme
-- 			component_separators = { left = "|", right = "|" },
-- 			section_separators = { left = "░", right = "░" }, -- Sleek pixel-mesh design blocks
-- 			disabled_filetypes = {
-- 				statusline = { "neo-tree", "lazy", "toggleterm", "help" },
-- 			},
-- 			globalstatus = true, -- Unified singular statusline across all active split windows
-- 		},
-- 		sections = {
-- 			lualine_a = { { "mode", separator = { right = "░" } } },
-- 			lualine_b = { "branch", "diff", "diagnostics" },
-- 			lualine_c = { { "filename", path = 1 } }, -- Shows relative path (e.g. lua/config/keybinds.lua)
--
-- 			lualine_x = {
-- 				-- 📡 ACTIVE BUFFER LSP DETECTOR
-- 				{
-- 					function()
-- 						local bufnr = vim.api.nvim_get_current_buf()
-- 						local clients = vim.lsp.get_clients({ bufnr = bufnr })
-- 						if next(clients) == nil then
-- 							return "📡 No LSP"
-- 						end
-- 						local c = {}
-- 						for _, client in pairs(clients) do
-- 							table.insert(c, client.name)
-- 						end
-- 						return "📡 " .. table.concat(c, "|")
-- 					end,
-- 					color = { fg = "#98c379", gui = "bold" },
-- 				},
-- 				-- 🤖 COPILOT LIVE STATUS INDICATOR
-- 				{
-- 					function()
-- 						-- 1. Check for copilot.lua (Lua API)
-- 						local ok, client = pcall(require, "copilot.client")
-- 						if ok and not client.is_disabled() then
-- 							return "🤖 Active"
-- 						end
--
-- 						-- 2. Fallback check for legacy copilot.vim global variables
-- 						if vim.g.copilot_enabled == 1 then
-- 							return "🤖 Active"
-- 						elseif vim.g.copilot_enabled == 0 then
-- 							return "🤖 Muted"
-- 						end
--
-- 						return "🤖 Offline"
-- 					end,
-- 					color = function()
-- 						-- Dynamic color switching based on Copilot state
-- 						local ok, client = pcall(require, "copilot.client")
-- 						if ok and not client.is_disabled() then
-- 							return { fg = "#61afef" } -- Bright blue when active
-- 						elseif vim.g.copilot_enabled == 0 then
-- 							return { fg = "#e5c07b" } -- Warm amber when paused
-- 						end
-- 						return { fg = "#e06c75" } -- Muted red when completely offline
-- 					end,
-- 				},
-- 				-- 🩺 Workspace toggle status monitors
-- 				{
-- 					function()
-- 						return vim.diagnostic.is_enabled() and "🩺" or "🩺 ❌"
-- 					end,
-- 					color = function()
-- 						return { fg = vim.diagnostic.is_enabled() and "#98c379" or "#e06c75" }
-- 					end,
-- 				},
-- 				{
-- 					function()
-- 						return vim.opt.spell:get() and "🔤" or ""
-- 					end,
-- 					color = { fg = "#e5c07b" },
-- 				},
-- 				"encoding",
-- 				"filetype",
-- 			},
-- 			lualine_y = { "progress" },
-- 			lualine_z = { { "location", separator = { left = "░" } } },
-- 		},
-- 	},
-- }
