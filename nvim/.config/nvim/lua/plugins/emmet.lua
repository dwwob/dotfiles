return {
	{
		"olrtg/nvim-emmet",
		config = function()
			vim.keymap.set({ "i", "v" }, "<C-e>", function()
				require("nvim-emmet").wrap_with_abbreviation()
			end, { desc = "Emmet: Wrap with Abbreviation" })
		end,
	},
}
