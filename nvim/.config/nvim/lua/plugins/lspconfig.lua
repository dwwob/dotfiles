return {
	"mattn/emmet-vim",
	ft = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" },
	init = function()
		-- Optional: Change default Emmet leader key
		vim.g.user_emmet_leader_key = ","
	end,
}
