return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- Load when opening a file
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				html = { "prettier" },
				css = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" }, -- Runs sequentially
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
			},
			-- Trigger auto-format on save
			format_on_save = {
				lsp_fallback = true, -- Fallback to LSP formatting if no formatter is found
				async = false,
				timeout_ms = 500,
			},
		})

		-- Optional keymap to format manually
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
