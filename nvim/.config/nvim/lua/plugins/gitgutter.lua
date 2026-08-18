-- ~/.config/nvim/lua/plugins/gitgutter.lua

-- return {
-- 	{
-- 		"lewis6991/gitsigns.nvim",
-- 		event = { "BufReadPre", "BufNewFile" },
-- 		opts = {
-- 			-- Modern, high-visibility Nerd Font symbols for your gutter
-- 			signs = {
-- 				add = { text = "" }, -- Plus icon
-- 				change = { text = "" }, -- Edit icon
-- 				delete = { text = "" }, -- Minus icon
-- 				topdelete = { text = "" }, -- Top delete icon
-- 				changedelete = { text = "" }, -- Combined edit/delete icon
-- 				untracked = { text = "" }, -- Question mark for untracked files
-- 			},
-- 			signs_staged = {
-- 				add = { text = "" },
-- 				change = { text = "" },
-- 				delete = { text = "" },
-- 				topdelete = { text = "" },
-- 				changedelete = { text = "" },
-- 			},
-- 			signcolumn = true, -- Toggle formatting inside the gutter explicitly
-- 			numhl = true, -- Toggle to true if you want the actual line numbers to change color on changes
-- 			linehl = false, -- Toggle to true if you want the entire code line highlighted on changes
-- 			word_diff = false, -- Toggle word-granular diff highlights
-- 			watch_gitdir = {
-- 				follow_files = true,
-- 			},
-- 			auto_attach = true,
-- 			attach_to_untracked = false,
-- 			current_line_blame = true, -- Toggle inline git blame per line
-- 			sign_priority = 6,
-- 			update_debounce = 100,
-- 			status_formatter = nil,
-- 			max_file_length = 40000,
-- 			preview_config = {
-- 				-- Matches your rounded window layout aesthetics used in the LSP module
-- 				border = "rounded",
-- 				style = "minimal",
-- 				relative = "cursor",
-- 				row = 0,
-- 				col = 1,
-- 			},
-- 		},
-- 	},
-- }

return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- Premium high-fidelity Nerd Fonts v3+ visual indicators
			signs = {
				add = { text = "▎" }, -- Sleek vertical accent bar
				change = { text = "░" }, -- Textured block for fast recognition
				delete = { text = "" }, -- Precise arrow right marker
				topdelete = { text = "▔" }, -- Clean upper border cap
				changedelete = { text = "▒" }, -- Multi-state textured block
				untracked = { text = "┆" }, -- Elegant dotted vertical separator
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "░" },
				delete = { text = "" },
				topdelete = { text = "▔" },
				changedelete = { text = "▒" },
			},
			signcolumn = true, -- Ensure icons display reliably in the gutter
			numhl = true, -- OPTION: Changes the line number color itself when a change occurs!
			linehl = false, -- Keep false to prevent massive background block highlights
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			current_line_blame = false,
			preview_config = {
				border = "rounded", -- Fluid curves to match your LSP popups
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
	},
}
--
