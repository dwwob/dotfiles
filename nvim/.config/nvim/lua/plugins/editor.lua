-- ~/.config/nvim/lua/plugins/editor.lua
return {
	-- =========================================================================
	-- 1. TELESCOPE.NVIM (FUZZY FINDER - FIXED WITH MASTER BRANCH)
	-- =========================================================================
	{
		"nvim-telescope/telescope.nvim",
		branch = "master", -- FIXED: Explicitly track master branch for modern treesitter compatibility
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
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
				{ "<leader>e", desc = "Toggle neotree file explorer" },
			},
		},
	},

	-- =========================================================================
	-- 3. GOTO-PREVIEW (FLOATING DEFINITION WINDOWS)
	-- =========================================================================
	{
		"rmagatti/goto-preview",
		event = "LspAttach",
		keys = {
			{
				"<leader>gpd",
				"<cmd>lua require('goto-preview').goto_preview_definition()<cr>",
				desc = "Preview Definition",
			},
			{
				"<leader>gpt",
				"<cmd>lua require('goto-preview').goto_preview_type_definition()<cr>",
				desc = "Preview Type Definition",
			},
			{
				"<leader>gpi",
				"<cmd>lua require('goto-preview').goto_preview_implementation()<cr>",
				desc = "Preview Implementation",
			},
			{
				"<leader>gpr",
				"<cmd>lua require('goto-preview').goto_preview_references()<cr>",
				desc = "Preview References",
			},
			{ "<leader>gpc", "<cmd>lua require('goto-preview').close_all_win()<cr>", desc = "Close All Previews" },
		},
		opts = {
			width = 120,
			height = 25,
			default_mappings = false,
			debug = false,
			opacity = nil,
			post_open_hook = nil,
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
			vim.g.gitgutter_diff_base = "HEAD"
			vim.opt.updatetime = 100
		end,
	},
}
