-- ~/.config/nvim/lua/plugins/coding/conform.lua
--
-- Cleaned-up version of your original file.
-- Every formatter and setting is the same as before -- nothing was
-- changed, moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- blink.lua, cobol_snippets.lua, init.lua, lazy.lua, auto.lua,
-- keybinds.lua, and options.lua, and each group kept together
-- under its own header.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/coding/ in your tree, so it
--     is covered by the "plugins.coding" import.
--   * Save order with auto.lua is right. This plugin loads on
--     BufWritePre and format_on_save runs before the file is
--     written; auto.lua's compile-and-run hooks are on
--     BufWritePost, after the write. So the code that gets
--     compiled or run (python3, gcc, g++, cobc, ./script) is
--     the already-formatted code.
--   * formatters_by_ft keys are filetypes, not extensions, and
--     they line up with filetypes.lua: mdx maps to "markdown",
--     so .mdx files get prettier; env files and .env.local map
--     to "sh", so they get shfmt.
--   * One gap: filetypes.lua maps tsconfig.json to "jsonc", but
--     there is no json or jsonc entry below, so JSON files are
--     not formatted on save. Left as-is.
--   * COBOL has no formatter below, so conform does nothing for
--     .cob / .cbl files. auto.lua's COBOL re-casing hook on
--     BufWritePost still handles those, and the two do not
--     overlap.
--   * No clash with nvim-lint / write-good. Linting only reports
--     problems in markdown and text files; prettier formatting
--     markdown on save does not fight it.
--   * No keymaps here, only the ConformInfo command, so nothing
--     clashes with keybinds.lua or with blink.lua's insert-mode
--     Tab / S-Tab / CR keymap.
--   * The formatter programs themselves (stylua, prettier, isort,
--     black, clang_format, google-java-format, shfmt) are not
--     installed by this spec -- it has no dependencies. If one is
--     missing, format_on_save's lsp_format = "fallback" uses
--     native LSP formatting instead.

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		-- -----------------------------------------------------------
		-- Formatters by file type
		-- -----------------------------------------------------------
		formatters_by_ft = {
			lua = { "stylua" },
			html = { "prettier" },
			css = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			markdown = { "prettier" },
			python = { "isort", "black" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			java = { "google-java-format" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
		},

		-- -----------------------------------------------------------
		-- Format on save
		-- -----------------------------------------------------------
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback", -- Use native LSP formatting if the binary fails
		},

		-- -----------------------------------------------------------
		-- Individual formatter overrides
		-- -----------------------------------------------------------
		formatters = {
			clang_format = {
				-- Instructs clang-format to respect any local project .clang-format configuration file.
				-- If no project file is found, it falls back to the clean, standardized LLVM structure layout style.
				prepend_args = { "--style=file", "--fallback-style=LLVM" },
			},
		},
	},
}
