-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  --     config = function()
  --       require("nvim-treesitter.configs").setup({
  -- --     ensure_installed = { "lua", "vim", "vimdoc", "html", "css", "javascript" },
  -- --     highlight = { enable = true },
  --         indent = { enable = true },
  --       })
  --     end,
}



-- return {
--
--   'nvim-treesitter/nvim-treesitter',
-- --  lazy = false,
--   build = ":TSUpdate",
-- --  config = function()
--  --   local configs = require("nvim-treesitter.configs")
--     --configs.setup({
-- --	highlight = {
-- --	    enable = true,
-- --	},
-- --	indent = { enable = true },
-- --j	autotage = { enable = true },
--   --  })
--
-- --end

-- }

