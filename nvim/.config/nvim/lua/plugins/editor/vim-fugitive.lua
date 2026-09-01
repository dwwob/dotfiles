-- =========================================================================
-- 4. VIM-FUGITIVE (GIT WRAPPER)
-- =========================================================================
return {
	"tpope/vim-fugitive",
	cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep" },
	keys = {
		{ "<leader>gs", "<cmd>Git<cr>", desc = "Git Status Panel" },
	},
}
