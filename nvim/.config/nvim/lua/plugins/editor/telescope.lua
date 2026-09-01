-- =========================================================================
-- 1. TELESCOPE.NVIM (FUZZY FINDER - RESOLVED FOR MODERN TREESITTER)
-- =========================================================================
return {
	"nvim-telescope/telescope.nvim",
	branch = "master", -- Tracks master branch for modern treesitter compatibility
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },

		-- Dedicated configuration shortcut pointing directly to your active dotfiles
		{
			"<leader>fc",
			function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.stdpath("config"),
					prompt_title = "Neovim Config Files",
				})
			end,
			desc = "Find Config Files",
		},
	},
	opts = {
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
				},
			},
		},
	},
}
