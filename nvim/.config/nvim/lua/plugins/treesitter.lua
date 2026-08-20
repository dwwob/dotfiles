-- ~/.config/nvim/lua/plugins/treesitter.lua
-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  -- treesitter.lua
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- FIXED: Pass configuration variables directly to the global options instead of calling .configs
      require("nvim-treesitter").setup({
        ensure_installed = { "lua", "vim", "html", "javascript", "typescript" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- ts-autotag.lua
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- ts-comments.lua
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- nvim-treesitter-cmp.lua
  { "ray-x/lsp_signature.nvim", event = "LspAttach" },
}





-- return {
--   -- treesitter.lua
--   {
--     "nvim-treesitter/nvim-treesitter",
--     build = ":TSUpdate",
--     event = { "BufReadPost", "BufNewFile" },
--     config = function()
--       require("nvim-treesitter.configs").setup({
--         ensure_installed = { "lua", "vim", "html", "javascript", "typescript" },
--         highlight = { enable = true },
--         indent = { enable = true },
--       })
--     end,
--   },
--
--   -- ts-autotag.lua
--   {
--     "windwp/nvim-ts-autotag",
--     event = { "BufReadPost", "BufNewFile" },
--     opts = {},
--   },
--
--   -- ts-comments.lua
--   {
--     "folke/ts-comments.nvim",
--     event = "VeryLazy",
--     opts = {},
--   },
--
--   -- nvim-treesitter-cmp.lua (legacy bridge helper if needed with tree-sitter queries)
--   { "ray-x/lsp_signature.nvim", event = "LspAttach" },
-- }
--
