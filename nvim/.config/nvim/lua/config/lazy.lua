-- ~/.config/nvim/init.lua

-- =========================================================================
-- 1. PRE-INITIALIZATION CONFIGURATION SETTINGS
-- =========================================================================
-- Leader keys MUST be mapped before lazy.nvim loads to ensure
-- mappings apply to plugins natively without context dropouts.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Initialize your custom mappings array layer immediately
require("config.keybinds")

-- =========================================================================
-- 2. LAZY.NVIM BOOTSTRAPPER CONTEXT
-- =========================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com"
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

-- =========================================================================
-- 3. DYNAMIC SUBFOLDER AUTOMATED SCANNER ENGINE
-- =========================================================================
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

-- =========================================================================
-- 4. LAZY SETUP EXECUTION LAYER WITH EXTENDED TIMEOUTS
-- =========================================================================
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
			-- FIX: Increases process timeout limit from 2 to 5 minutes
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
