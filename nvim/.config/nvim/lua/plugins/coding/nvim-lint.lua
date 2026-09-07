-- ~/.dotfiles/nvim/.config/nvim/lua/plugins/coding/nvim-lint.lua

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("lint").linters_by_ft = {}
	end,
}
