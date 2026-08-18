-- ~/.config/nvim/lua/plugins/ts-comments.lua

return {
	"folke/ts-comments.nvim",
	opts = {},
	event = "VeryLazy",
	enabled = vim.fn.has("nvim-0.10.0") == 1,
}
