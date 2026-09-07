-- ~/.config/nvim/lua/plugins/ui/telescope.lua

return {
	"nvim-telescope/telescope.nvim",
	-- FIX: Replace branch = "0.1.x" with version = "*" to grab the modern integration patch
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep Text" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Active Buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search Help Tags" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },

		-- Stow & Git dotfiles search from anywhere
		{
			"<leader>fd",
			function()
				local stow_root = vim.fn.expand("~/.dotfiles")
				if vim.fn.isdirectory(stow_root) == 0 then
					stow_root = vim.fn.expand("~/dotfiles")
				end

				require("telescope.builtin").find_files({
					prompt_title = "📦 Stow Dotfiles Repository",
					cwd = stow_root,
					follow = true,
					hidden = true,
					no_ignore = false,
				})
			end,
			desc = "Search Dotfiles Repository",
		},
	},
	opts = {
		defaults = {
			path_display = { "truncate" },
			sorting_strategy = "ascending",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
				},
			},
			mappings = {
				i = {
					["<C-j>"] = function(...)
						return require("telescope.actions").move_selection_next(...)
					end,
					["<C-k>"] = function(...)
						return require("telescope.actions").move_selection_previous(...)
					end,
				},
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzf")
	end,
}

-- -- ~/.config/nvim/lua/plugins/ui/telescope.lua
--
-- return {
-- 	"nvim-telescope/telescope.nvim",
-- 	branch = "0.1.x",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
-- 	},
-- 	keys = {
-- 		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
-- 		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep Text" },
-- 		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Active Buffers" },
-- 		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search Help Tags" },
-- 		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
-- 	},
-- 	opts = {
-- 		defaults = {
-- 			path_display = { "truncate" },
-- 			sorting_strategy = "ascending",
-- 			layout_config = {
-- 				horizontal = {
-- 					prompt_position = "top",
-- 					preview_width = 0.55,
-- 				},
-- 			},
-- 			mappings = {
-- 				i = {
-- 					["<C-j>"] = function(...)
-- 						return require("telescope.actions").move_selection_next(...)
-- 					end,
-- 					["<C-k>"] = function(...)
-- 						return require("telescope.actions").move_selection_previous(...)
-- 					end,
-- 				},
-- 			},
-- 		},
-- 	},
-- 	config = function(_, opts)
-- 		local telescope = require("telescope")
-- 		telescope.setup(opts)
-- 		telescope.load_extension("fzf")
-- 	end,
-- }

-- -- =========================================================================
-- -- 1. TELESCOPE.NVIM (FUZZY FINDER - RESOLVED FOR MODERN TREESITTER)
-- -- =========================================================================
-- return {
-- 	"nvim-telescope/telescope.nvim",
-- 	branch = "master", -- Tracks master branch for modern treesitter compatibility
-- 	dependencies = { "nvim-lua/plenary.nvim" },
-- 	keys = {
-- 		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
-- 		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
-- 		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
-- 		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
--
-- 		-- Dedicated configuration shortcut pointing directly to your active dotfiles
-- 		{
-- 			"<leader>fc",
-- 			function()
-- 				require("telescope.builtin").find_files({
-- 					cwd = vim.fn.stdpath("config"),
-- 					prompt_title = "Neovim Config Files",
-- 				})
-- 			end,
-- 			desc = "Find Config Files",
-- 		},
-- 	},
-- 	opts = {
-- 		defaults = {
-- 			mappings = {
-- 				i = {
-- 					["<C-j>"] = "move_selection_next",
-- 					["<C-k>"] = "move_selection_previous",
-- 				},
-- 			},
-- 		},
-- 	},
-- }
