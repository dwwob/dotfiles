-- ~/.config/nvim/lua/plugins/coding/emmet_vim.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- mason.lua, conform.lua, blink.lua, cobol_snippets.lua, init.lua,
-- lazy.lua, auto.lua, keybinds.lua, and options.lua, and each
-- group kept together under its own header. The top line is
-- corrected from the dotfiles path in your paste to the config
-- path above, and the stray "--" line under it is removed.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/coding/ in your tree, so it
--     is covered by the "plugins.coding" import.
--   * Lazy loading by filetype: ft below means emmet-vim loads
--     only in html, css, javascriptreact, typescriptreact, and
--     vue buffers, not at startup and not in other files.
--   * init runs before the plugin loads, which is the right
--     place for these vim.g globals -- lazy.nvim runs init even
--     for a lazy-loaded plugin, so the keys below are set in
--     time for emmet-vim to read them.
--   * No clash with blink.lua. blink's insert-mode keymap is
--     <Tab>, <S-Tab>, and <CR>; Emmet expands with ",," here,
--     not Tab, so the two do not fight over a key. Both can
--     offer expansions in the same html / css / react buffers:
--     blink through its completion menu, Emmet with ",,".
--   * No clash with keybinds.lua. Your <leader> is Space, and
--     keybinds.lua has no "," mappings and no insert-mode ","
--     mapping -- "jk" to leave Insert mode is untouched. The
--     "," below is Emmet's own leader (user_emmet_leader_key),
--     a separate global from vim.g.mapleader, so neither one
--     overwrites the other.
--   * Visual tag wrapping lines up: user_emmet_mode = "a"
--     below enables Insert, Normal, and Visual hooks, and the
--     html expand_abbr_key in user_emmet_settings is the rule
--     the visual wrap uses. That is the fix the original header
--     described, kept exactly.
--   * One comment corrected: the original usage note said to
--     type ", ," (comma space comma) in Visual mode, but both
--     expand keys are set to ",," with no space. The keys were
--     left as-is and the note below now says ",,".
--   * Gap -- plain javascript and typescript are not in ft
--     below, only the react variants, so Emmet does not load
--     in plain .js or .ts buffers, even though conform.lua
--     formats those filetypes with prettier. Left as-is.
--   * Gap -- vue is in ft below, but conform.lua has no vue
--     entry in formatters_by_ft, so vue files get Emmet here
--     but no prettier formatting on save there. Left as-is.
--   * filetypes.lua does not change any of this: it maps mdx
--     to "markdown" and tsconfig.json to "jsonc", and neither
--     markdown nor jsonc is in ft below, so Emmet does not
--     load in those buffers either.
--   * No autocmds or save hooks here, so nothing overlaps
--     auto.lua's BufWritePost compile-and-run or conform.lua's
--     BufWritePre format on save.

return {
	"mattn/emmet-vim",
	ft = { "html", "css", "javascriptreact", "typescriptreact", "vue" },
	init = function()
		-- -----------------------------------------------------------
		-- Expansion keys
		-- -----------------------------------------------------------
		-- Set your primary insert mode expansion leader prefix (e.g., ,, to expand)
		vim.g.user_emmet_leader_key = ","
		vim.g.user_emmet_expandabbr_key = ",,"

		-- -----------------------------------------------------------
		-- Visual tag wrapping
		-- -----------------------------------------------------------
		-- Maps the visual wrap action sequence explicitly to your preferred keys
		-- Usage: Highlight text in visual mode, type ,, to open the prompt
		vim.g.user_emmet_settings = {
			html = {
				-- Ties the classic visual abbreviation mapping rule
				expand_abbr_key = ",,",
			},
		}

		-- -----------------------------------------------------------
		-- Mode
		-- -----------------------------------------------------------
		vim.g.user_emmet_mode = "a" -- Allow all interaction hooks (Insert, Normal, Visual)
	end,
}
