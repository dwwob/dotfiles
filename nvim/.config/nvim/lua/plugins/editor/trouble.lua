-- ~/.config/nvim/lua/plugins/editor/trouble.lua

return {
	"folke/trouble.nvim",
	opts = {}, -- Uses modern v3 default configurations out-of-the-box
	cmd = "Trouble",
	keys = {
		{
			"<leader>tx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics Panel (Trouble)",
		},
		{
			"<leader>td",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics Only (Trouble)",
		},
		{
			"<leader>tq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}
