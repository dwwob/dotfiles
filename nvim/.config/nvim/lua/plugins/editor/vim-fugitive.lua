-- ~/.config/nvim/lua/plugins/editor/vim-fugitive.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- trouble.lua, telescope.lua, inline.lua, nvim-lint.lua,
-- toggleterm.lua, git.lua, ts-autopairs.lua, treesitter.lua,
-- nvim-lspconfig.lua, lsp_signature.lua, goto-preview.lua,
-- emmet_vim.lua, mason.lua, conform.lua, blink.lua, init.lua,
-- lazy.lua, auto.lua, keybinds.lua, and options.lua, and the
-- spec kept together under its own header. The original numbered
-- banner ("4. VIM-FUGITIVE (GIT WRAPPER)") is dropped, like the
-- numbered banners in the other cleaned files.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/editor/, so it is covered by
--     the "plugins.editor" import.
--   * Lazy loading: the cmd list and the keys list below are
--     the triggers -- lazy.nvim loads vim-fugitive on the first
--     of its commands (G, Git, Gdiffsplit, Gread, Gwrite, Ggrep)
--     or on <leader>gs, not at startup. There is no opts and no
--     config function, so the plugin runs entirely on its own
--     defaults once loaded.
--   * DUPLICATE -- <leader>gs, flagged and left as-is:
--     here <leader>gs is <cmd>Git<cr> ("Git Status Panel"),
--     and keybinds.lua maps <leader>gs globally to
--     <cmd>Git<CR> ("Git Status Pane"). Same key, same mode,
--     and the exact same command -- only the description
--     wording differs ("Panel" here, "Pane" in keybinds.lua).
--     Unlike the <leader>td clash in trouble.lua, this is not
--     two different jobs fighting for one key: both do the
--     same thing, so whichever mapping wins, <leader>gs still
--     opens the Git status view. It is a harmless duplicate;
--     you could drop one copy later, but nothing breaks if
--     both stay.
--
--   * keybinds.lua depends on this plugin: <leader>gd there
--     is <cmd>Gdiffsplit<CR> ("Git Diff Split") and
--     <leader>gc is <cmd>Git commit<CR> ("Git Commit").
--     Both commands are in this file's cmd list -- "Gdiffsplit"
--     and "Git" -- so lazy.nvim knows to load vim-fugitive
--     when those commands are run, and the keybinds.lua keys
--     work. If this spec or its cmd list were removed, those
--     two keybinds would have no plugin behind them.
--   * Complements git.lua, does not overlap it: git.lua is
--     gitsigns (signs, hunk navigation, inline blame, and
--     <leader>gph / <leader>gbl / <leader>gdf / <leader>grh
--     buffer-locally), while this file is vim-fugitive (the
--     :Git status panel and the G... commands). They share
--     the <leader>g prefix, but no exact key is used by both
--     except <leader>gd / <leader>gdf, already flagged in
--     git.lua: <leader>gd in keybinds.lua is a prefix of
--     git.lua's <leader>gdf, so Neovim waits a moment after
--     <leader>gd in a gitsigns buffer. That diff view itself
--     (<cmd>Gdiffsplit<CR>) is a fugitive command from this
--     file.
--   * No autocmds or save hooks here of its own, so nothing
--     overlaps conform.lua's format on save, nvim-lint.lua's
--     lint autocmds, or auto.lua's compile-and-run. Its only
--     triggers are the lazy.nvim cmd and keys above.

-- ---------------------------------------------------------------------------
-- Vim Fugitive
-- ---------------------------------------------------------------------------
return {
	"tpope/vim-fugitive",
	cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep" },
	keys = {
		{ "<leader>gs", "<cmd>Git<cr>", desc = "Git Status Panel" },
	},
}
