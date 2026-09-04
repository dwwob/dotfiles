-- ~/.dotfiles/nvim/.config/nvim/lua/plugins/coding/autoclose.lua

return {
	"m4xshen/autoclose.nvim",
	config = function()
		require("autoclose").setup()
	end,
}
