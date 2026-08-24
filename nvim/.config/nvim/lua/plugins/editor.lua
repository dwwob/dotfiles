-- ~/.config/nvim/lua/plugins/editor.lua
return {
	-- =========================================================================
	-- 1. TELESCOPE.NVIM (FUZZY FINDER - RESOLVED FOR MODERN TREESITTER)
	-- =========================================================================
	{
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
	},

	-- =========================================================================
	-- 2. WHICH-KEY.NVIM (KEYBINDING VISUALIZER)
	-- =========================================================================
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			spec = {
				{ "<leader>f", group = "Find / Telescope" },
				{ "<leader>g", group = "Git / Preview" },
				{ "<leader>e", desc = "Toggle File Explorer" },
			},
		},
	},

	-- =========================================================================
	-- 3. NATIVE DEFINITION SPLIT (BOTTOM VIEW - REPLACES GOTO-PREVIEW FLOATS)
	-- =========================================================================
	{
		"neovim/nvim-lspconfig",
		event = "LspAttach",
		keys = {
			-- FIXED: Automatically opens a horizontal split window at the very bottom
			{
				"<leader>gpd",
				"<cmd>botright split | lua vim.lsp.buf.definition()<cr>",
				desc = "Definition at Bottom",
			},
			{
				"<leader>gpr",
				"<cmd>botright split | lua vim.lsp.buf.references()<cr>",
				desc = "References at Bottom",
			},
		},
	},

	-- =========================================================================
	-- 4. VIM-FUGITIVE (GIT WRAPPER)
	-- =========================================================================
	{
		"tpope/vim-fugitive",
		cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep" },
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>", desc = "Git Status Panel" },
		},
	},

	-- =========================================================================
	-- 5. VIM-GITGUTTER (SIGN COLUMN DIFF INDICATORS)
	-- =========================================================================
	{
		"airblade/vim-gitgutter",
		event = { "BufReadPost", "BufNewFile" },
		init = function()
			-- Snappy visual update loops when buffer content modifications occur
			vim.g.gitgutter_diff_base = "HEAD"
			vim.opt.updatetime = 100
		end,
	},
}
