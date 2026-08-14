return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim" },
	config = function()
		require("mason").setup()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"emmet-ls",
				"stylua", -- Lua formatter
				"prettier", -- Web formatter (JS/TS/HTML/CSS)
				"eslint_d", -- Fast JS/TS linter
				"pylint", -- Python linter
				"black", -- Python formatter
			},
		})
	end,
}
