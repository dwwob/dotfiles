-- =========================================================================
-- 2. WHICH-KEY.NVIM (KEYBINDING VISUALIZER)
-- =========================================================================
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		spec = {
			{ "<leader>f", group = "Find / Telescope" },
			{ "<leader>g", group = "Git / Preview" },
			{ "<leader>t", group = "Toggle Options" },
			{ "<leader>e", desc = "Toggle File Explorer" },
		},
	},
}
