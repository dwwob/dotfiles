-- ~/.config/nvim/lua/plugins/editor/which-key.lua

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
			{ "<leader>tc", desc = "Floating Command Launcher" },
			{ "<leader>td", desc = "Buffer Diagnostics Only (Trouble)" },
			{ "<leader>tf", desc = "Toggle Floating Terminal Shell" },
			{ "<leader>tg", desc = "Toggle Lazygit Dashboard" },
			{ "<leader>th", desc = "Toggle Horizontal Terminal Split" },
			{ "<leader>tl", desc = "Toggle Line Wrap" },
			{ "<leader>tn", desc = "Toggle Relative Line Numbers" },
			{ "<leader>tp", "<cmd>LivePreview<cr>", desc = "Start Realtime HTML Viewer" }, -- 🚀 Added Start Preview
			{ "<leader>tP", "<cmd>LivePreviewStop<cr>", desc = "Stop Realtime HTML Viewer" }, -- 🚀 Added Stop Preview
			{ "<leader>tq", desc = "Quickfix List (Trouble)" },
			{ "<leader>ts", desc = "Toggle Spell Check" },
			{ "<leader>tv", desc = "Toggle Vertical Terminal Split" },
			{ "<leader>tw", desc = "Toggle Deprecation Warnings" },
			{ "<leader>tx", desc = "Diagnostics Panel (Trouble)" },
			{ "<leader>sa", desc = "Add Word to cspell Dictionary" },
		},
	},
}

-- -- ~/.config/nvim/lua/plugins/editor/which-key.lua
--
-- return {
-- 	"folke/which-key.nvim",
-- 	event = "VeryLazy",
-- 	opts = {
-- 		preset = "modern",
-- 		spec = {
-- 			-- Top-Level Prefix Definitions
-- 			{ "<leader>e", desc = "Toggle File Explorer" },
-- 			{ "<leader>f", group = "Find / Telescope", icon = "🔍" },
-- 			{ "<leader>g", group = "Git / Preview", icon = "📊" },
-- 			{ "<leader>t", group = "Toggles/Terminals", icon = "⚙️" },
--
-- 			-- Git Details Submenu Labels
-- 			{ "<leader>gb", desc = "Toggle Line Blame" },
-- 			{ "<leader>gd", desc = "View File Diff Window" },
-- 			{ "<leader>gp", desc = "Preview Hunk Float" },
-- 			{ "<leader>gr", desc = "Reset Current Hunk" },
--
-- 			-- Toggles / Terminals Child Items
-- 			{ "<leader>td", desc = "Buffer Diagnostics Only (Trouble)" }, -- Updated description for clarity
-- 			{ "<leader>tf", desc = "Toggle Floating Terminal Shell" },
-- 			{ "<leader>tg", desc = "Toggle Lazygit Dashboard" },
-- 			{ "<leader>th", desc = "Toggle Horizontal Terminal Split" },
-- 			{ "<leader>tl", desc = "Toggle Line Wrap" },
-- 			{ "<leader>tn", desc = "Toggle Relative Line Numbers" },
-- 			{ "<leader>tq", desc = "Quickfix List (Trouble)" }, -- 🚀 Added Trouble diagnostic key
-- 			{ "<leader>ts", desc = "Toggle Spell Check" },
-- 			{ "<leader>tv", desc = "Toggle Vertical Terminal Split" },
-- 			{ "<leader>tw", desc = "Toggle Deprecation Warnings" },
-- 			{ "<leader>tx", desc = "Diagnostics Panel (Trouble)" }, -- 🚀 Added Trouble diagnostic key
-- 		},
-- 	},
-- }
