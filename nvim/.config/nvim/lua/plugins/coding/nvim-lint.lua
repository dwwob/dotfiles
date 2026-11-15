-- ~/.config/nvim/lua/plugins/coding/nvim-lint.lua
--
-- =========================================================================
-- Nvim-Lint
-- =========================================================================
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			markdown = { "write_good" },
			text = { "write_good" },
		}

		-- Gutter sign for write-good only, in its own namespace, so the
		-- global diagnostic signs in options.lua are left unchanged.
		-- "✎" is one cell wide with no trailing space, to avoid the
		-- Invalid 'sign_text' error.
		local ns = require("lint").get_namespace("write_good")
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.WARN] = "✎",
				},
			},
		}, ns)

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
