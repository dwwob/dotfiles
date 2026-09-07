-- ~/.config/nvim/lua/plugins/ui/which-key.lua

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		spec = {
			-- Top-Level Prefix Definitions
			{ "<leader>e", desc = "Toggle File Explorer" },
			{ "<leader>f", group = "Find / Telescope", icon = "🔍" },
			{ "<leader>g", group = "Git / Preview", icon = "📊" },
			{ "<leader>t", group = "Toggles/Terminals", icon = "⚙️" },

			-- Git Details Submenu Labels
			{ "<leader>gb", desc = "Toggle Line Blame" },
			{ "<leader>gd", desc = "View File Diff Window" },
			{ "<leader>gp", desc = "Preview Hunk Float" },
			{ "<leader>gr", desc = "Reset Current Hunk" },

			-- Toggles / Terminals Child Items
			{ "<leader>td", desc = "Toggle Inline Diagnostics" },
			{ "<leader>tf", desc = "Toggle Floating Terminal Shell" },
			{ "<leader>tg", desc = "Toggle Lazygit Dashboard" },
			{ "<leader>th", desc = "Toggle Horizontal Terminal Split" },
			{ "<leader>tl", desc = "Toggle Line Wrap" },
			{ "<leader>tn", desc = "Toggle Relative Line Numbers" },
			{ "<leader>ts", desc = "Toggle Spell Check" },
			{ "<leader>tv", desc = "Toggle Vertical Terminal Split" },
			{ "<leader>tw", desc = "Toggle Deprecation Warnings" },
		},
	},
}
