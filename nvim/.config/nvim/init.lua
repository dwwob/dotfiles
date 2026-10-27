-- ~/.config/nvim/init.lua
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"

-- Experimental UI2 framework initialization
-- Note: Internal '_core' namespaces can change across patch versions
require("vim._core.ui2").enable({})

-- Mute standard runtime deprecation logs on screen
vim.g.deprecation_warnings = false

-- Load modular configurations
require("config.options")
--require("config.keybinds") -- Un-commented to load your updated keymaps!
require("config.lazy")
require("config.auto")
require("config.filetypes")

-- Native Wayland clipboard synchronization engine
if vim.fn.has("wsl") == 0 and os.getenv("WAYLAND_DISPLAY") then
	vim.g.clipboard = {
		name = "wl-copy",
		copy = {
			["+"] = "wl-copy --type text/plain",
			["*"] = "wl-copy --type text/plain",
		},
		paste = {
			["+"] = "wl-paste --no-newline",
			["*"] = "wl-paste --no-newline",
		},
		cache_enabled = 1,
	}
end
