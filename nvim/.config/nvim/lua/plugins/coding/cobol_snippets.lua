-- ~/.config/nvim/lua/plugins/coding/cobol_snippets.lua

return {
	"saghen/blink.cmp",
	opts = {
		sources = {
			providers = {
				snippets = {
					opts = {
						-- Forces local lookup paths to inject custom blocks
						search_paths = { vim.fn.expand("~/.config/nvim/snippets") },
					},
				},
			},
		},
	},
	init = function()
		-- 🚀 GLOBAL Boilerplate Shortcut: Spits out a pristine, complete code file structure!
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "cobol",
			callback = function()
				vim.keymap.set("n", "<leader>cc", function()
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
					-- Inject lines at current cursor position
					vim.api.nvim_buf_set_lines(0, 0, -1, false, boilerplate)
					vim.notify("🏗️ COBOL Boilerplate structure generated!", vim.log.levels.INFO)
				end, { buffer = true, desc = "Generate Complete COBOL Boilerplate" })
			end,
		})
	end,
}
