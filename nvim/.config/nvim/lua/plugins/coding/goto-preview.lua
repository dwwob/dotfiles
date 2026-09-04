-- ~/.dotfiles/nvim/.config/nvim/lua/plugins/coding/goto-preview.lua

return {
	"rmagatti/goto-preview",
	event = "BufRead",
	config = function()
		require("goto-preview").setup({
			default_mappings = true, -- Sets gpd, gpi, gpr, etc.
		})
	end,
}
