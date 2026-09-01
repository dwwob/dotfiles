-- ~.config/nvim/init.lua
vim.g.deprecation_warnings = false

-- ============================================
-- require("vim._core.vi2").enable({})
-- ============================================
require("config.options")
require("config.keybinds")
require("config.lazy")
require("config.auto")
