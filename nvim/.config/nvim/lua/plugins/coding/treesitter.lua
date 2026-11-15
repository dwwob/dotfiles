-- ~/.config/nvim/lua/plugins/treesitter.lua
--
-- Cleaned-up version of your original file, with one removal
-- you approved: the duplicate BufWritePre format hook is gone
-- (see below). Every other setting is the same as before --
-- nothing else was changed, moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- nvim-lspconfig.lua, lsp_signature.lua, goto-preview.lua,
-- emmet_vim.lua, mason.lua, conform.lua, blink.lua, init.lua,
-- lazy.lua, auto.lua, keybinds.lua, and options.lua.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits directly in lua/plugins/ (not in coding/),
--     so it is covered by the "plugins" import itself.
--   * Structure kept as-is: the return is a table wrapping the
--     single spec in another table, unlike the coding/ files,
--     which return their spec directly. lazy.nvim accepts both.
--   * Loads on BufReadPost / BufNewFile, not at startup, and
--     build = ":TSUpdate" updates the parsers on install/update.
--   * ensure_installed below is TREESITTER's own parser list --
--     bash, lua, vim, vimdoc, html, xml, css, javascript, and
--     typescript. It is NOT the mason-lspconfig ensure_installed
--     you removed because of the deprecation warnings on
--     Neovim 0.12 (you are on 0.12.5). This one installs
--     treesitter parsers, not LSP servers, so it stays. Left
--     exactly as-is.
--   * Parser coverage gap: there is no parser in that list for
--     python, c, cpp, cobol, markdown, or json, even though
--     auto.lua compiles/runs python, c, cpp, and cobol, and
--     conform.lua formats python, c, and cpp. Those filetypes
--     get no treesitter highlight or indent from this list.
--     Left as-is.
--   * nvim-ts-autotag is a dependency here and is set up in the
--     config below; it uses the html / xml parsers, which are
--     in the ensure_installed list, so tag auto-closing has the
--     parsers it needs.
--   * No keymaps here, so nothing clashes with keybinds.lua,
--     nvim-lspconfig.lua's LspAttach keymaps, goto-preview.lua,
--     or blink.lua / emmet_vim.lua in Insert mode.
--   * REMOVED -- duplicate format hook: this file used to have
--     a BufWritePre hook calling require("conform").format()
--     for *.html, *.lua, *.js, and *.ts. conform.lua already
--     has format_on_save, also on BufWritePre, for those same
--     filetypes (html and javascript/typescript get prettier,
--     lua gets stylua), so those files were formatted twice
--     on every save. You approved removing this hook. It does
--     not break formatting: conform.lua's format_on_save
--     still formats html, lua, js, and ts on save on its own.
--   * Save order is still right: conform's format runs on
--     BufWritePre, before the write, and auto.lua's
--     compile-and-run hooks are on BufWritePost, after it,
--     so compiled code is the already-formatted code.
--
return {
	-- ---------------------------------------------------------------------------
	-- Nvim-Treesitter (code parsing & highlights)
	-- ---------------------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"windwp/nvim-ts-autotag", -- Seamlessly hooks into treesitter parsers
		},
		-- Pass configuration preferences directly via standard lazy opts table
		opts = {
			ensure_installed = { "bash", "lua", "vim", "vimdoc", "html", "xml", "css", "javascript", "typescript" },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		},
		config = function(_, opts)
			-- Use the primary module setup entry point instead of the .configs submodule
			require("nvim-treesitter").setup(opts)

			-- Initialize the autotag engine cleanly
			require("nvim-ts-autotag").setup()
		end,
	},
}
