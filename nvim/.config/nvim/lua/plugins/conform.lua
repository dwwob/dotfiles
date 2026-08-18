-- ~/.config/nvim/lua/plugins/conform.lua

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			rust = { "rustfmt", lsp_format = "fallback" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			html = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
			jsonc = { "prettierd", "prettier", stop_after_first = true },
			bash = { "shfmt" },
			sh = { "shfmt" },
			zsh = { "shfmt" },

			-- Native Pascal configuration
			pascal = { "ptop" },
		},

		-- Custom shfmt spacing overrides
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2", "-ci" },
			},
		},

		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
