return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true, -- Enable Treesitter integration
			ts_config = {
				lua = { "string" }, -- Ignore string nodes in Lua
				javascript = { "template_string" },
			},
		})
	end,
}
