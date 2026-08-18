-- ~/.config/nvim/lua/plugins/mason.lua

return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = {}, -- This forces a safe fallback configuration
	},
}
