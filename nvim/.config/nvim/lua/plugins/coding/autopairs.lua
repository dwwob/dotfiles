-- ~/.dotfils/nvim/.config/nvim/lua/plugins/coding/autopairs.lua

-- =========================================================================
-- 3. PAIRS & CLOSES (AUTOPAIRS ONLY)
-- =========================================================================
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			disable_filetype = { "TelescopePrompt" },
			check_ts = true,
		})
	end,
}
