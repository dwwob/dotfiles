-- ~.config/nvim/init.lua
vim.g.deprecation_warnings = false

-- ============================================
-- require("vim._core.vi2").enable({})
-- ============================================
require("config.lazy")
require("config.options")
require("config.keybinds")
require("config.auto")

-- Wayland clipboard integration
vim.opt.clipboard = "unnamedplus"
if vim.fn.has("wsl") == 0 and os.getenv("WAYLAND_DISPLAY") then
	vim.g.clipboard = {
		name = 'wl-copy',
		copy = {
			['+'] = 'wl-copy --type text/plain',
			['*'] = 'wl-copy --type text/plain',
		},
		paste = {
			['+'] = 'wl-paste --no-newline',
			['*'] = 'wl-paste --no-newline',
		},
		cache_enabled = 1,
	}
end

-- Load file types configuration
require("config.filetypes")
