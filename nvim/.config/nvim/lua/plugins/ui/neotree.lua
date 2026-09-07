-- ~/.config/nvim/lua/plugins/ui/neotree.lua

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle filesystem left<cr>", desc = "Toggle File Explorer" },
	},
	opts = {
		close_if_last_window = true,
		filesystem = {
			follow_current_file = { enabled = true },
			filtered_items = {
				visible = false,
				hide_dotfiles = false, -- Keeps Stow dotfiles visible
				hide_gitignored = false, -- Shows gitignored code/assets
			},
			window = {
				mappings = {
					["<space>"] = "none", -- Frees up spacebar so leader commands work inside the tree
				},
			},
		},
		window = {
			width = 30,
			mappings = {
				["H"] = "toggle_hidden",
			},
		},
	},
}
