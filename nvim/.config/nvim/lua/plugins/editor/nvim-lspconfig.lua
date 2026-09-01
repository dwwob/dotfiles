-- =========================================================================
-- 3. NATIVE DEFINITION SPLIT (BOTTOM VIEW - REPLACES GOTO-PREVIEW FLOATS)
-- =========================================================================
return {
	"neovim/nvim-lspconfig",
	event = "LspAttach",
	keys = {
		-- FIXED: Automatically opens a horizontal split window at the very bottom
		{
			"<leader>gpd",
			"<cmd>botright split | lua vim.lsp.buf.definition()<cr>",
			desc = "Definition at Bottom",
		},
		{
			"<leader>gpr",
			"<cmd>botright split | lua vim.lsp.buf.references()<cr>",
			desc = "References at Bottom",
		},
	},
}
