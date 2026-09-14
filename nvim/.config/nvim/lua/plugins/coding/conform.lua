-- ~/.config/nvim/lua/plugins/coding/conform.lua

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		-- 1. Map target formatting utilities by file type extension
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
		},

		-- 2. Configure background options for save-triggers
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback", -- Use native LSP formatting if the binary fails
		},

		-- 3. 🚀 Overrides for individual formatter parameters
		formatters = {
			clang_format = {
				-- Instructs clang-format to respect any local project .clang-format configuration file.
				-- If no project file is found, it falls back to the clean, standardized LLVM structure layout style.
				prepend_args = { "--style=file", "--fallback-style=LLVM" },
			},
		},
	},
}
