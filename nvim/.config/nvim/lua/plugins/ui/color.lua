-- ~/.config/nvim/lua/plugins/ui/color.lua
--
-- Cleaned-up version of your original file.
-- Every colour and setting is the same as before -- nothing was
-- changed, moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- which-key.lua, vim-fugitive.lua, trouble.lua, telescope.lua,
-- inline.lua, nvim-lint.lua, toggleterm.lua, git.lua,
-- ts-autopairs.lua, treesitter.lua, nvim-lspconfig.lua,
-- lsp_signature.lua, goto-preview.lua, emmet_vim.lua, mason.lua,
-- conform.lua, blink.lua, init.lua, lazy.lua, auto.lua,
-- keybinds.lua, and options.lua, and the spec kept together
-- under its own header.
-- The original numbered banner ("1. COLOR.LUA & VIVID DARK
-- THEME OVERRIDES") is dropped, like the numbered banners in
-- the other cleaned files.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/ui/, so it is covered by
--     the "plugins.ui" import.
--   * Not lazy-loaded: lazy = false with priority = 1000 means
--     lazy.nvim loads it at startup, ahead of the lazy plugins,
--     and its config runs then -- setup() first, then
--     vim.cmd([[colorscheme tokyonight]]), so the theme and
--     the on_highlights overrides below are active before the
--     other plugins draw. No other cleaned file sets a
--     colorscheme, so nothing competes with or overwrites it.
--   * options.lua lines up with it: termguicolors = true is
--     what lets the hex colours below (#00f0ff, #ff007f,
--     #8D918D, #8996db) display as written, number = true and
--     relativenumber = true are what show the LineNr /
--     LineNrAbove / LineNrBelow stack the overrides colour,
--     and cursorline = true is what makes the CursorLineNr
--     override visible on the current line.
--   * Transparent background: transparent = true, with
--     styles.sidebars = "transparent" and styles.floats =
--     "transparent", means Neovim draws no background of its
--     own for the editor, sidebars, or floating windows -- the
--     terminal / desktop background behind it shows through.
--     That includes Telescope, Trouble, and floating terminal
--     windows. Left exactly as-is.
--   * NOTE -- HTML groups, flagged and left as-is: htmlTag,
--     htmlTagName, htmlArg, htmlComment, and htmlCommentPart
--     are the legacy Vim syntax group names. treesitter.lua
--     sets highlight.enable = true with
--     additional_vim_regex_highlighting = false, so in a
--     treesitter-highlighted HTML buffer the highlighting
--     comes mainly from treesitter captures, not those legacy
--     groups, and these overrides may have little or no visible
--     effect there. They do not break anything, and the
--     Comment override is separate -- Comment is the group
--     comments are linked through, so the vivid comment colour
--     still applies. Nothing was changed here.
--   * No Diagnostic or GitSigns highlight groups are overridden
--     here, so options.lua's diagnostic signs, git.lua's
--     gitsigns signs and blame, and inline.lua's inline
--     diagnostics all keep tokyonight's moon colours for those
--     groups -- this file only recolours the groups listed in
--     on_highlights below.
--   * No keymaps, autocmds, or save hooks here of its own, so
--     nothing overlaps conform.lua's format on save,
--     nvim-lint.lua's lint autocmds, or auto.lua's
--     compile-and-run. Its only trigger is startup loading.
--
-- ---------------------------------------------------------------------------
-- Tokyo Night (colour scheme & vivid dark theme overrides)
-- ---------------------------------------------------------------------------
return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "moon", -- High-vibrancy dark base style
			transparent = true, -- Enable beautiful transparent background
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},

			-- Vivid colour definitions: force maximum contrast and high-visibility
			on_highlights = function(hl, c)
				local vivid_neon_blue = "#00f0ff"
				local vivid_neon_pink = "#ff007f"
				local vivid_gunmetal_gray = "#8D918D"
				local highly_visible_gray = "#8996db"

				-- Line numbers (active vs. relative inactive stack)
				hl.CursorLineNr = { fg = vivid_neon_blue, bold = true } -- Active center line number
				hl.LineNr = { fg = highly_visible_gray, bold = false } -- Inactive stack lines
				hl.LineNrAbove = { fg = highly_visible_gray, bold = false } -- Stack numbers above
				hl.LineNrBelow = { fg = highly_visible_gray, bold = false } -- Stack numbers below

				-- High-visibility HTML tags & web code elements
				hl.htmlTag = { fg = vivid_neon_pink, bold = true } -- HTML angle brackets
				hl.htmlTagName = { fg = vivid_neon_pink, bold = true } -- HTML structural tag names
				hl.htmlArg = { fg = vivid_neon_blue, italic = true } -- HTML class/id attributes

				-- High-visibility comments (forces glowing neon gray text blocks)
				hl.Comment = { fg = vivid_gunmetal_gray, bold = true, italic = true }
				hl.htmlComment = { fg = vivid_gunmetal_gray, bold = true, italic = true }
				hl.htmlCommentPart = { fg = vivid_gunmetal_gray, bold = true, italic = true }
			end,
		})

		-- Safely initialize the theme with overrides active
		vim.cmd([[colorscheme tokyonight]])
	end,
}
