-- ~/.config/nvim/lua/plugins/ui/telescope.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- inline.lua, nvim-lint.lua, toggleterm.lua, git.lua,
-- ts-autopairs.lua, treesitter.lua, nvim-lspconfig.lua,
-- lsp_signature.lua, goto-preview.lua, emmet_vim.lua, mason.lua,
-- conform.lua, blink.lua, init.lua, lazy.lua, auto.lua,
-- keybinds.lua, and options.lua, and the spec kept together
-- under its own header.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/ui/, so it is covered by
--     the "plugins.ui" import.
--   * Lazy loading: there is no event / cmd trigger here, so the
--     keys list below is what loads this plugin -- lazy.nvim
--     loads it on the first of <leader>ff, <leader>fg,
--     <leader>fb, <leader>fh, <leader>fr, <leader>tc, or
--     <leader>fd, not at startup. config then runs
--     telescope.setup(opts) and load_extension("fzf"), for the
--     telescope-fzf-native.nvim dependency built with "make".
--   * DUPLICATED keys -- <leader>ff / fg / fb / fh, left as-is:
--     keybinds.lua also maps those four, to the exact same
--     Telescope commands (find_files, live_grep, buffers,
--     help_tags), so both definitions do the same job and
--     neither changes what the key does. Only the descriptions
--     differ slightly: "Live Grep Text" here vs "Live Grep" in
--     keybinds.lua, and "Find Active Buffers" here vs "Find
--     Buffers" there. <leader>fr (oldfiles), <leader>tc, and
--     <leader>fd are only in this file.
--   * README CLASH -- <leader>tc, flagged and left as-is:
--     here <leader>tc is the Floating Terminal Command
--     Launcher (Telescope's commands picker, run in a floating
--     ToggleTerm), while the README lists <leader>tc as
--     Compile & Run Current Script. Those are two different
--     jobs for one key. There is no <leader>tc mapping in
--     keybinds.lua, and auto.lua's compile-and-run is a
--     BufWritePost autocmd on save, not a <leader>tc mapping,
--     so in this config <leader>tc does the launcher here,
--     not compile-and-run. Decide which meaning the README
--     should keep; nothing was changed here.
--   * That launcher depends on toggleterm.lua: on selection it
--     runs ToggleTerm direction=float cmd='<chosen command>'.
--     ToggleTerm is in toggleterm.lua's cmd list, so lazy.nvim
--     can load toggleterm.nvim for it, the same floating
--     terminal layer as <C-\> and <leader>tf.
--   * <leader>tc sits in keybinds.lua's <leader>t toggle group
--     (td, tf, tg, th, ti, tl, tn, ts, tv, tw), but none of
--     those is <leader>tc itself, so there is no direct
--     overwrite -- it just shares the t prefix.
--   * README GAP -- <leader>fc, flagged and left as-is: the
--     README lists <leader>fc for jumping into config files,
--     but there is no <leader>fc mapping in this file and none
--     in keybinds.lua, so that key does nothing until a mapping
--     is added. <leader>fd below IS here: Search Dotfiles
--     Repository, checking ~/.dotfiles first and falling back
--     to ~/dotfiles, with follow = true, hidden = true, and
--     no_ignore = false.
--   * Insert-mode <C-j> / <C-k> below only apply inside the
--     Telescope prompt (mappings.i), moving the selection next
--     / previous. They do not clash with keybinds.lua's normal-
--     mode <C-j> / <C-k> window navigation -- different mode
--     and different context.
--   * No autocmds or save hooks here of its own, so nothing
--     overlaps conform.lua's format on save, treesitter.lua,
--     nvim-lint.lua's lint autocmds, or auto.lua's
--     compile-and-run. Its only triggers are the lazy.nvim
--     keys above.

-- ---------------------------------------------------------------------------
-- Telescope
-- ---------------------------------------------------------------------------
return {
	"nvim-telescope/telescope.nvim",
	-- Replace branch = "0.1.x" with version = "*" to grab the modern integration patch
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

		-- Floating Terminal Command Launcher
		{
			"<leader>tc",
			function()
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")

				require("telescope.builtin").commands({
					prompt_title = "🚀 Terminal Command Launcher",
					layout_strategy = "center",
					layout_config = {
						width = 0.6,
						height = 0.4,
					},
					attach_mappings = function(prompt_bufnr, _)
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							if selection then
								-- Run the chosen item directly inside your active floating terminal layer
								vim.cmd("ToggleTerm direction=float cmd='" .. selection.value .. "'")
							end
						end)
						return true
					end,
				})
			end,
			desc = "Floating Terminal Command Launcher",
		},

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
