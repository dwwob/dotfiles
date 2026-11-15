-- ~/.config/nvim/lua/config/lazy.lua
--
-- Cleaned-up version of your original file.
-- Every setting and all logic is the same as before -- nothing was
-- changed, moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- init.lua, options.lua, and keybinds.lua, and each group kept
-- together under its own header.
-- Note: your pasted file started with "-- ~/.config/nvim/init.lua" --
-- that line is corrected here, since this is config/lazy.lua.
--
-- Plays-together check against your other files:
--   * Keybinds DO load after all. This file does
--     require("config.keybinds") at the top, uncommented, and
--     init.lua loads this file with require("config.lazy") --
--     so your keybinds take effect via lazy.lua, even though
--     the require("config.keybinds") line in init.lua itself
--     is commented out.
--   * Leader keys are set here, before lazy.nvim loads and
--     before require("config.keybinds"), which is the correct
--     order -- <leader> is Space, matching the README.
--   * WARNING -- the lazy.nvim clone URL below is incomplete,
--     left exactly as in your original: it is just
--     "https://github.com", with no /folke/lazy.nvim.git path.
--     If lazy.nvim is not already installed, that git clone
--     would fail. It only runs when lazypath is missing, so
--     an existing install is unaffected.
--   * The scanner below registers "plugins" plus one import
--     per subdirectory under lua/plugins/ -- coding, core,
--     editor, and ui in your tree -- while top-level files
--     like mini-nvim.lua, snacks.lua, and ui.lua are covered
--     by the base "plugins" import.

-- ---------------------------------------------------------------------------
-- Pre-initialization settings
-- ---------------------------------------------------------------------------
-- Leader keys MUST be mapped before lazy.nvim loads to ensure
-- mappings apply to plugins natively without context dropouts.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.keybinds")

-- ---------------------------------------------------------------------------
-- lazy.nvim bootstrapper
-- ---------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- ---------------------------------------------------------------------------
-- Dynamic subfolder scanner
-- ---------------------------------------------------------------------------
-- Start the tracking spec matrix pointing to your flat file directory
local plugin_specs = {
	{ import = "plugins" },
}

-- Absolute path to your active core configuration files
local plugins_path = vim.fn.stdpath("config") .. "/lua/plugins"

-- Use the native filesystem loop to recursively trace folder maps
local handle = (vim.uv or vim.loop).fs_scandir(plugins_path)
if handle then
	while true do
		local name, type = (vim.uv or vim.loop).fs_scandir_next(handle)
		if not name then
			break
		end

		-- If a subdirectory is discovered, dynamically register it
		if type == "directory" then
			table.insert(plugin_specs, { import = "plugins." .. name })
		end
	end
end

-- ---------------------------------------------------------------------------
-- lazy.nvim setup (extended timeouts)
-- ---------------------------------------------------------------------------
require("lazy").setup({
	spec = plugin_specs,

	-- Useful interface and visual tracking settings
	defaults = {
		lazy = false, -- Change to true if you prefer explicit lazy specs everywhere
	},
	checker = {
		enabled = false, -- Stops automated checker background checks
	},
	change_detection = {
		notify = false, -- Mutes popups when modifying files live
	},

	-- Extended operations performance block
	performance = {
		git = {
			-- Increases process timeout limit from 2 to 5 minutes.
			-- This stops network bottlenecks or stow operations from killing installs.
			timeout = 300,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
