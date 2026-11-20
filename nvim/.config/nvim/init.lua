-- ~/.config/nvim/init.lua
--
-- Cleaned-up version of your original file.
-- Every setting and require is the same as before -- nothing was
-- changed, moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- options.lua and keybinds.lua, and each group kept together under
-- its own header.
--
-- Plays-together check against your other files:
--   * config.options, config.lazy, config.auto, and
--     config.filetypes all exist in lua/config/ and load in the
--     same order as before.
--   * The clipboard block below only runs when you are not in
--     WSL and WAYLAND_DISPLAY is set, which matches your
--     openSUSE / KDE Wayland setup.

-- ---------------------------------------------------------------------------
-- Encoding
-- ---------------------------------------------------------------------------
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"

-- ---------------------------------------------------------------------------
-- Experimental UI2
-- ---------------------------------------------------------------------------
-- Note: Internal '_core' namespaces can change across patch versions
require("vim._core.ui2").enable({})

-- ---------------------------------------------------------------------------
-- Deprecation warnings
-- ---------------------------------------------------------------------------
-- Mute standard runtime deprecation logs on screen
vim.g.deprecation_warnings = false

-- ---------------------------------------------------------------------------
-- Load modular configurations
-- ---------------------------------------------------------------------------
require("config.options")
-- require("config.keybinds") -- Un-commented to load your updated keymaps!
require("config.lazy")
require("config.auto")
require("config.filetypes")

-- ---------------------------------------------------------------------------
-- Clipboard (Wayland)
-- ---------------------------------------------------------------------------
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
