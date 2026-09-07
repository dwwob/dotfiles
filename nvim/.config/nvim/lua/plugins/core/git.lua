-- ~/.config/nvim/lua/plugins/core/git.lua

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true,
		watch_gitdir = { follow_files = true },
		current_line_blame = true, -- Adds subtle dim ghost-text inline blame
		current_line_blame_opts = {
			delay = 400,
			virt_text_pos = "eol",
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation keys to jump between modified hunks
			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Next Git Hunk" })

			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Previous Git Hunk" })

			-- Bindings matching your Which-Key menu requirements
			map("n", "<leader>gph", gs.preview_hunk, { desc = "Preview Hunk Float" })
			map("n", "<leader>gbl", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
			map("n", "<leader>gdf", gs.diffthis, { desc = "View File Diff Window" })
			map("n", "<leader>grh", gs.reset_hunk, { desc = "Reset Current Hunk" })
		end,
	},
}
