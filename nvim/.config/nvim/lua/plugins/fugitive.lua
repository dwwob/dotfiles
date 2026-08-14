-- return {
--   "tpope/vim-fugitive",
--   cmd = { "Git", "G" }, -- Lazy loads the plugin only when you run these commands
-- }
--
return {
	"tpope/vim-fugitive",
	keys = {
		{ "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
		{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff Split" },
		{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
		{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
	},
}
