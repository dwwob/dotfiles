-- ~/.dotfiles/nvim/.config/nvim/lua/plugins/coding/emmet_vim.lua
--
-- =========================================================================
-- 4. LEGACY EMMET-VIM (FIXED FOR VISUAL TAG WRAPPING)
-- =========================================================================
return {
	"mattn/emmet-vim",
	ft = { "html", "css", "javascriptreact", "typescriptreact", "vue" },
	init = function()
		-- Set your primary insert mode expansion leader prefix (e.g., ,, to expand)
		vim.g.user_emmet_leader_key = ","
		vim.g.user_emmet_expandabbr_key = ",,"

		-- FIXED: Maps the visual wrap action sequence explicitly to your preferred keys
		-- Usage: Highlight text in visual mode, type , , (comma space comma) to open the prompt
		vim.g.user_emmet_settings = {
			html = {
				-- Ties the classic visual abbreviation mapping rule
				expand_abbr_key = ",,",
			},
		}

		vim.g.user_emmet_mode = "a" -- Allow all interaction hooks (Insert, Normal, Visual)
	end,
}
