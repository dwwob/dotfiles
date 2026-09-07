-- =========================================================================
-- 4. LSP SIGNATURE FLOATING HELPER
-- =========================================================================
return {
	"ray-x/lsp_signature.nvim",
	event = "LspAttach",
	opts = {
		bind = true,
		handler_opts = { border = "rounded" },
	},
}
