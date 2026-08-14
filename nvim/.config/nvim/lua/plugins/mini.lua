return {
	{
		"nvim-mini/mini.nvim",
		version = false, -- Use false for the main branch, or "*" for stable releases
		config = function()
			-- Mini.statusline: Simple and fast statusline
			require("mini.statusline").setup()

			-- Mini.pairs: Automatic closing of quotes, brackets, and parentheses
			require("mini.pairs").setup()

			-- Mini.comment: Smart, fast comment toggling (via `gc`)
			-- require("mini.comment").setup()

			-- Mini.starter: Minimal start screen for your dashboard
			require("mini.starter").setup()

			-- Mini.surround: Manage surrounding actions like tags, brackets, and quotes
			require("mini.surround").setup()

			-- mini cmdline
			require("mini.cmdline").setup()

			require("mini.notify").setup()

			require("mini.pick").setup()

			require("mini.extra").setup()

			require("mini.keymap").setup()

			require("mini.doc").setup()

			require("mini.files").setup()

			require("mini.misc").setup()

			require("mini.pick").setup()

			require("mini.operators").setup()
		end,
	},
}
