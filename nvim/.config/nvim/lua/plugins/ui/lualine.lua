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
