-- ~/.config/nvim/lua/plugins/gitgutter.lua

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- add your custom options here if needed
	},
}
-- ```
--
-- ### Key Features Included by Default
-- * **Sign Column Markers:** Shows indicators for added, modified, and deleted lines.
-- * **Hunk Actions:** Jump between changes, preview, stage, or reset hunks.
-- * **Compatibility:** Fully optimized to run smoothly on modern Neovim versions.
--
