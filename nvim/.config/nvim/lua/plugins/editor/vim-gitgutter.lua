return {
	-- =========================================================================
	-- 5. VIM-GITGUTTER (SIGN COLUMN DIFF INDICATORS)
	-- =========================================================================
	{
		"airblade/vim-gitgutter",
		event = { "BufReadPost", "BufNewFile" },
		init = function()
			-- Snappy visual update loops when buffer content modifications occur
			vim.g.gitgutter_diff_base = "HEAD"
			vim.opt.updatetime = 100
		end,
	},
}
