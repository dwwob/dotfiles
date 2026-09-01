return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("lint").linters_by_ft = {}
	end,
}
