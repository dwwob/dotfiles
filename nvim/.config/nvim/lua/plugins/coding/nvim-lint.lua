return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			markdown = { "write_good" },
			text = { "write_good" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}

-- -- ~/.dotfiles/nvim/.config/nvim/lua/plugins/coding/nvim-lint.lua
--
-- return {
-- 	"mfussenegger/nvim-lint",
-- 	event = { "BufReadPost", "BufNewFile" },
-- 	config = function()
-- 		require("lint").linters_by_ft = {}
-- 	end,
-- }
