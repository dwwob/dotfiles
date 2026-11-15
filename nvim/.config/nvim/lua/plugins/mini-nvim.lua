-- ~/.config/nvim/lua/plugins/mini-nvim.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- neotree.lua, lualine.lua, indent-blankline.lua, color.lua,
-- which-key.lua, vim-fugitive.lua, trouble.lua, telescope.lua,
-- inline.lua, nvim-lint.lua, toggleterm.lua, git.lua,
-- ts-autopairs.lua, treesitter.lua, nvim-lspconfig.lua,
-- lsp_signature.lua, goto-preview.lua, emmet_vim.lua, mason.lua,
-- conform.lua, blink.lua, init.lua, lazy.lua, auto.lua,
-- keybinds.lua, and options.lua, and the spec kept together
-- under its own header.
-- The original numbered banner (6. MINI UTILITIES) is dropped,
-- like the numbered banners in the other cleaned files, and
-- the stray ")" in the "mini files" comment is dropped from
-- that comment only. No setting is affected by either.
--
-- Bugs fixed at your request -- nothing else changed:
--   * Typo fixed -- vim.api.nvim_bur_get_name in the
--     <leader>- mapping below is now
--     vim.api.nvim_buf_get_name ("bur" corrected to "buf").
--   * Broken "-" mapping fixed -- it was a string,
--     " <cmd>lua MiniFiles.open()<CR>", with a leading space
--     before <cmd>, and MiniFiles is a local variable in
--     this config function, so a :lua string command could
--     not see it. It is now a function-form mapping that
--     calls the local MiniFiles.open() directly, the same
--     way the <leader>- mapping below it does.
--   * Also kept exactly: the <leader>ps desc is " grep",
--     with its original leading space.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits directly in lua/plugins/, so it is covered
--     by the "plugins" import itself. event = "VeryLazy" means
--     it loads after startup, and config then runs every
--     mini.* setup and keymap below in order.
--   * Watch-out, left as-is -- mini.surround vs brackets:
--     mini.surround is set up with defaults here, so it adds
--     and changes brackets / quotes around existing text.
--     blink.lua has completion.accept.auto_brackets enabled,
--     which adds a closing bracket when a completion is
--     accepted, and ts-autopairs.lua is nvim-autopairs
--     (InsertEnter, check_ts = true), which pairs brackets
--     and quotes as you type them. That is three separate
--     systems touching brackets and quotes in the same
--     buffers. They act at different moments -- surround on
--     existing text, autopairs on typing, blink on accept --
--     so there is no proven double-pairing today, but if you
--     ever see a doubled closing bracket, this overlap is
--     the first place to look.
--   * Two picker systems, no direct key clash -- mini.pick
--     here uses <leader>pf (files), <leader>ps (grep the word
--     under the cursor), <leader>vh (help), <leader>xx
--     (diagnostics via mini.extra), and <leader>pk (keymaps).
--     telescope.lua uses <leader>ff (find_files), <leader>fg
--     (live_grep), <leader>fb (buffers), <leader>fh
--     (help_tags), <leader>fr (oldfiles), <leader>tc, and
--     <leader>fd. No key is shared, so nothing overwrites
--     anything, but the jobs overlap: pf and ff both find
--     files, ps greps only the word under the cursor while
--     fg is a live grep prompt, and vh and fh both search
--     help. <leader>xx and <leader>pk have no Telescope
--     equivalent in that file; xx is a picker view of the
--     same diagnostics trouble.lua lists on <leader>tx /
--     td / tq, with no shared key.
--   * Two file explorers, no direct key clash -- mini.files
--     here opens on "-" and on <leader>- for the current
--     file, while
--     neotree.lua toggles Neo-tree on <leader>e. Different
--     keys, so neither mapping replaces the other; you simply
--     have two explorers available. Inside mini.files, the
--     mappings below are kept exactly: <CR> go_in, L
--     go_in_plus, _ go_out, and H go_out_plus -- those are
--     mini.files window-local keys, and its H does not clash
--     with Neo-tree's window-local H = toggle_hidden.
--   * mini.cmdline, mini.notify, and mini.ai are set up with
--     the values below and define no <leader> keys of their
--     own in this file, so they add no clash with
--     keybinds.lua or which-key.lua. which-key.lua has no
--     <leader>pf / ps / vh / xx / pk, "-" or <leader>- entry,
--     so those keys get no which-key label from that file.
--   * No autocmds or save hooks here of its own, so nothing
--     overlaps conform.lua's format on save, nvim-lint.lua's
--     lint autocmds, or auto.lua's compile-and-run.
--
-- ---------------------------------------------------------------------------
-- Mini.nvim (mini utilities)
-- ---------------------------------------------------------------------------
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

		-- mini files
		local MiniFiles = require("mini.files")
		MiniFiles.setup({
			mappings = {
				go_in = "<CR>",
				go_in_plus = "L",
				go_out = "_",
				go_out_plus = "H",
			},
		})

		vim.keymap.set("n", "-", function()
			MiniFiles.open()
		end, { desc = "Toggle mini files explorer" })
		vim.keymap.set("n", "<leader>-", function()
			MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
			MiniFiles.reveal.cwd()
		end, { desc = "Toggle into currently opened file" })
	end,
}
