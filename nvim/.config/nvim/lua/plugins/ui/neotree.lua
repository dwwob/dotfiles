-- ~/.config/nvim/lua/plugins/ui/neotree.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- lualine.lua, indent-blankline.lua, color.lua, which-key.lua,
-- vim-fugitive.lua, trouble.lua, telescope.lua, inline.lua,
-- nvim-lint.lua, toggleterm.lua, git.lua, ts-autopairs.lua,
-- treesitter.lua, nvim-lspconfig.lua, lsp_signature.lua,
-- goto-preview.lua, emmet_vim.lua, mason.lua, conform.lua,
-- blink.lua, init.lua, lazy.lua, auto.lua, keybinds.lua, and
-- options.lua, and the spec kept together under its own header.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/ui/, so it is covered by
--     the "plugins.ui" import. It has no event or cmd trigger,
--     so its keys entry is the lazy-loading trigger.
--   * Duplicate flagged, left as-is -- <leader>e: here it is
--     "<cmd>Neotree toggle filesystem left<cr>", and
--     keybinds.lua maps <leader>e globally to
--     "<cmd>Neotree toggle<cr>". Both are described as
--     "Toggle File Explorer" and both toggle Neo-tree -- this
--     file's version just names the filesystem source and the
--     left position explicitly. Same job, not two different
--     jobs, so whichever mapping wins the explorer still
--     toggles; nothing breaks if both stay.
--   * which-key.lua lines up with that: its spec has a
--     desc-only { "<leader>e", desc = "Toggle File Explorer" }
--     entry, which labels this same key and creates no
--     mapping of its own.
--   * The filesystem window mapping ["<space>"] = "none"
--     is kept exactly: it frees up the Spacebar inside the
--     tree. Your <leader> key is Space, so without it the
--     tree would swallow Space and leader commands would
--     not work while the cursor is in the Neo-tree window.
--     With it set to "none", leader commands work inside
--     the tree, as the original comment said.
--   * "H" = "toggle_hidden" in the top-level window
--     mappings is a Neo-tree window-local key, not a global
--     one, so it does not clash with any keybinds.lua
--     mapping; it toggles hidden files in the tree, on top
--     of the filtered_items defaults below.
--   * filtered_items is kept exactly: visible = false,
--     hide_dotfiles = false (Stow dotfiles stay visible,
--     which suits the ~/.dotfiles tree telescope.lua's
--     <leader>fd searches), and hide_gitignored = false
--     (gitignored code/assets are shown). Neo-tree only
--     displays the filesystem here -- git.lua (gitsigns)
--     and vim-fugitive.lua keep the Git signs, hunks,
--     blame, and :Git panel.
--   * Dependencies are kept exactly: plenary.nvim (shared
--     with telescope.lua), nvim-web-devicons (the file-type
--     icons in the tree), and nui.nvim. branch = "v3.x"
--     is kept.
--   * No autocmds, user commands, or save hooks here of
--     its own, so nothing overlaps conform.lua's format
--     on save, nvim-lint.lua's lint autocmds, or auto.lua's
--     compile-and-run, and it sets no diagnostic or sign
--     options, so options.lua, inline.lua, and trouble.lua
--     are untouched.
--
-- ---------------------------------------------------------------------------
-- Neo-tree (file explorer)
-- ---------------------------------------------------------------------------
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
