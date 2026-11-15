-- ~/.config/nvim/lua/plugins/coding/cobol_snippets.lua
--
-- Cleaned-up version of your original file, with two fixes applied:
--   * Boilerplate shortcut moved from <leader>cc to <leader>cb so it
--     no longer clashes with keybinds.lua's <leader>cc toggle comment.
--   * Boilerplate now inserts at the cursor line instead of
--     replacing the whole buffer, so existing contents are kept.
-- Everything else is the same as before -- nothing was moved in
-- order or removed. Layout uses one header style throughout,
-- matching blink.lua, init.lua, lazy.lua, auto.lua, keybinds.lua,
-- and options.lua, and each group kept together under its own header.
-- The emoji inside the notify string below is kept exactly.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/coding/ in your tree, so it
--     is covered by the "plugins.coding" import.
--   * Second spec for the same plugin: this is another spec for
--     "saghen/blink.cmp", on top of the main spec in blink.lua.
--     lazy.nvim merges specs for the same plugin, so this file
--     adds to blink.lua rather than replacing it -- but see the
--     search_paths clash below.
--   * search_paths clash with blink.lua: blink.lua sets the
--     snippets provider's search_paths = {} (empty), while this
--     file sets search_paths = { "~/.config/nvim/snippets" }.
--     Both set the same provider option, so only one of them can
--     win when lazy.nvim merges the two specs. Left as-is in
--     both files, exactly as in your originals -- decide which
--     one should hold the path, and clear the other.
--   * <leader>cb (FIXED): the boilerplate shortcut now uses
--     <leader>cb instead of <leader>cc, so it no longer clashes
--     with keybinds.lua's global <leader>cc toggle comment
--     ("gcc"). In COBOL buffers <leader>cb generates the
--     boilerplate and <leader>cc still toggles the comment.
--   * Boilerplate inserts at cursor (FIXED): the boilerplate is
--     now inserted at the current cursor line instead of
--     replacing the whole buffer with
--     nvim_buf_set_lines(0, 0, -1, ...). Anything already in
--     the buffer is kept when you press <leader>cb.
--   * auto.lua agrees on COBOL: its BufWritePost compiler and
--     its COBOL re-casing hook both trigger on *.cob / *.cbl,
--     and this file's FileType autocmd triggers on "cobol",
--     which is the filetype those extensions get.

return {
	"saghen/blink.cmp",
	opts = {
		sources = {
			providers = {
				snippets = {
					opts = {
						-- -----------------------------------------------------------
						-- Snippet search path
						-- -----------------------------------------------------------
						-- Forces local lookup paths to inject custom blocks
						search_paths = { vim.fn.expand("~/.config/nvim/snippets") },
					},
				},
			},
		},
	},
	init = function()
		-- -----------------------------------------------------------
		-- COBOL boilerplate shortcut (<leader>cb, COBOL buffers only)
		-- -----------------------------------------------------------
		-- Global boilerplate shortcut: spits out a complete code
		-- file structure
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "cobol",
			callback = function()
				vim.keymap.set("n", "<leader>cb", function()
					local boilerplate = {
						"       IDENTIFICATION DIVISION.",
						"       PROGRAM-ID.  HELLO-WORLD.",
						"       AUTHOR.      DANIEL WOBKER.",
						"       ",
						"       ENVIRONMENT DIVISION.",
						"       CONFIGURATION SECTION.",
						"       ",
						"       DATA DIVISION.",
						"       FILE SECTION.",
						"       ",
						"       WORKING-STORAGE SECTION.",
						'       01  WS-DESCRIPTION  PIC X(35) VALUE "COBOL RUNNING PERFECTLY".',
						"       ",
						"       PROCEDURE DIVISION.",
						"       0000-MAIN-LOGIC.",
						"           DISPLAY WS-DESCRIPTION.",
						"           STOP RUN.",
					}
					-- Insert the boilerplate at the current cursor line,
					-- keeping anything already in the buffer
					local row = vim.api.nvim_win_get_cursor(0)[1] - 1
					vim.api.nvim_buf_set_lines(0, row, row, false, boilerplate)
					vim.notify("🏗️ COBOL Boilerplate structure generated!", vim.log.levels.INFO)
				end, { buffer = true, desc = "Generate Complete COBOL Boilerplate" })
			end,
		})
	end,
}
