-- ~/.config/nvim/lua/config/filetypes.lua
--
-- Cleaned-up version of the original file.
-- Every filetype mapping is the same as before -- nothing was
-- changed, moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- init.lua, options.lua, and keybinds.lua, and each group kept
-- together under its own header.
--
-- Plays-together check against your other files:
--   * init.lua loads this file with require("config.filetypes"),
--     uncommented and last in its load order, so these mappings
--     do take effect -- unlike config.keybinds, which is still
--     commented out in init.lua.
--   * The name matches on both sides: init.lua asks for
--     "config.filetypes" and this file sits in lua/config/ as
--     filetypes.lua in your tree.
--   * env = "sh" and .env.local = "sh" agree with each other --
--     filename rules win over extension rules in
--     vim.filetype.add, but both give "sh", so there is no
--     conflict.
--   * Files given the "sh" filetype here (.env, .env.local) get
--     shell highlighting, but auto.lua's auto-compile triggers
--     on the *.sh filename pattern, not on filetype -- so saving
--     an .env file will not try to run it as a script.
--   * mdx = "markdown" means .mdx files get the same markdown
--     handling as .md files, including the write-good linting
--     set up for markdown in nvim-lint.lua.
--   * tsconfig.json = "jsonc" allows comments in that file,
--     which plain "json" would flag as errors.

-- ---------------------------------------------------------------------------
-- Custom filetypes
-- ---------------------------------------------------------------------------
vim.filetype.add({
	-- By extension
	extension = {
		mdx = "markdown",
		env = "sh",
		conf = "config",
	},

	-- By exact filename
	filename = {
		[".env.local"] = "sh",
		["tsconfig.json"] = "jsonc",
	},
})
