-- ==========================================================================	-
-- 6. MINI UTILITIES
-- =========================================================================
return {
	"echasnovski/mini.nvim",
	version = false,
	event = "VeryLazy",
	config = function()
		-- mini.ai
		require("mini.ai").setup()

		-- mini.surround
		require("mini.surround").setup()

		-- mini.cmdline
		require("mini.cmdline").setup({
			-- Settings for as-you-type completion
			completion = {
				-- Delay (in ms) between keypress and showing completion menu
				delay = 50,
			},

			-- Settings for as-you-type autocorrect (fixes common typos)
			autocorrect = {
				-- Set to true to automatically correct words with unique matches
				enable = true,
			},

			-- Settings for visual previews of commands (e.g., seeing :%s/old/new live)
			autopeek = {
				-- Set to true to show the affected lines in a floating window
				enable = true,

				-- Number of context lines to show above and below the preview
				n_lines = 1,
			},
		})

		-- mini.notify
		require("mini.notify").setup({
			-- only show messages
			content = {
				format = function(notif)
					return notif.msg
				end,
			},
		})

		-- mini picker
		local MiniPick = require("mini.pick")
		local MiniExtra = require("mini.extra")

		MiniPick.setup()
		MiniExtra.setup()

		vim.keymap.set("n", "<leader>pf", function()
			MiniPick.builtin.files()
		end, { desc = "Mini Files Picker" })
		vim.keymap.set("n", "<leader>ps", function()
			MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
		end, { desc = " grep" })
		vim.keymap.set("n", "<leader>vh", function()
			MiniPick.builtin.help()
		end, { desc = "Mini Help" })

		vim.keymap.set("n", "<leader>xx", function()
			MiniExtra.pickers.diagnostic()
		end, { desc = "Mini Picker Diagnostics" })
		vim.keymap.set("n", "<leader>pk", function()
			MiniExtra.pickers.keymaps()
		end, { desc = "Search keymaps" })

		-- mini files )
		local MiniFiles = require("mini.files")
		MiniFiles.setup({
			mappings = {
				go_in = "<CR>",
				go_in_plus = "L",
				go_out = "_",
				go_out_plus = "H",
			},
		})

		vim.keymap.set("n", "-", " <cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini files explorer" })
		vim.keymap.set("n", "<leader>-", function()
			MiniFiles.open(vim.api.nvim_bur_get_name(0), false)
			MiniFiles.reveal.cwd()
		end, { desc = "Toggle into currently opened file" })
	end,
}
