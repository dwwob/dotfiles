-- ~/.config/nvim/lua/plugins/ui.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- snacks.lua, mini-nvim.lua, neotree.lua, lualine.lua,
-- indent-blankline.lua, color.lua, which-key.lua,
-- vim-fugitive.lua, trouble.lua, telescope.lua, inline.lua,
-- nvim-lint.lua, toggleterm.lua, git.lua, ts-autopairs.lua,
-- treesitter.lua, nvim-lspconfig.lua, lsp_signature.lua,
-- goto-preview.lua, emmet_vim.lua, mason.lua, conform.lua,
-- blink.lua, init.lua, lazy.lua, auto.lua, keybinds.lua, and
-- options.lua, and the spec kept together under its own header.
-- The nested shape is kept exactly: the return holds one
-- table, and that table holds the single nvim-notify spec.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits directly in lua/plugins/ as ui.lua, so it
--     is covered by the base "plugins" import itself.
--   * Its keys entry is the lazy-loading trigger, so the
--     plugin loads on <leader>un, and config runs at that
--     load: require("notify").setup(opts), then
--     vim.notify = require("notify"). Left as-is: until the
--     plugin has loaded, vim.notify is still Neovim's default,
--     so vim.notify(...) calls in keybinds.lua, auto.lua,
--     toggleterm.lua, and cobol_snippets.lua use the default
--     handler first and nvim-notify after it has loaded.
--     Those files are callers, not competing handlers.
--   * Clash flagged, left as-is -- <leader>un: here it is
--     require("notify").dismiss({ silent = true,
--     pending = true }), desc "Dismiss All Notifications",
--     and snacks.lua also maps <leader>un to
--     Snacks.notifier.hide(), with the same desc. In the
--     clash-fixed snacks.lua, notifier = { enabled = false },
--     so the Snacks notifier no longer displays anything --
--     but its <leader>un key entry is still in snacks.lua
--     and still calls hide() on that disabled notifier.
--     Same key, same desc, and the same intent (dismiss
--     notifications), but two different systems behind it;
--     whichever mapping wins, the other system's dismiss
--     is not the one that runs. Nothing was removed here.
--
--   * vim.notify vs the other notify systems: this file is
--     the one that assigns vim.notify, with
--     vim.notify = require("notify") in config. mini-nvim.lua
--     sets up mini.notify on VeryLazy with a content format
--     that returns notif.msg only, and it contains no
--     vim.notify = assignment, so it does not overwrite
--     this one -- mini.notify handles its own notifications
--     alongside it. The Snacks notifier no longer competes
--     either, now that it is disabled in snacks.lua.
--     That still leaves two active display systems in total
--     (nvim-notify for vim.notify calls, mini.notify for
--     its own), exactly as in your original setup.
--   * opts are kept exactly: stages = "fade" and
--     timeout = 3000.
--   * which-key.lua has no <leader>un entry, so this key
--     gets no which-key label from that file; the desc here
--     is the label lazy.nvim / which-key will show.
--   * No autocmds, user commands, or save hooks here of
--     its own, so nothing overlaps conform.lua's format
--     on save, nvim-lint.lua's lint autocmds, or auto.lua's
--     compile-and-run, and it sets no diagnostic or sign
--     options, so options.lua, inline.lua, and trouble.lua
--     are untouched.
--
-- ---------------------------------------------------------------------------
-- Nvim Notify (notifications)
-- ---------------------------------------------------------------------------
return {
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss All Notifications",
			},
		},
		opts = {
			stages = "fade",
			timeout = 3000,
		},
		config = function(_, opts)
			require("notify").setup(opts)
			vim.notify = require("notify")
		end,
	}
}
