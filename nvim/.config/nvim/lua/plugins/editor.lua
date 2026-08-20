-- ~/.config/nvim/lua/plugins/editor.lua
return {
  -- telescope.lua
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    },
  },

  -- whichkey.lua
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- gotopreview.lua
  {
    "rmagatti/goto-preview",
    event = "LspAttach",
    config = function()
      require("goto-preview").setup({})
    end,
  },

  -- fugitive.lua
  { "tpope/vim-fugitive", cmd = { "G", "Git" } },

  -- gitgutter.lua
  { "airblade/vim-gitgutter", event = { "BufReadPost", "BufNewFile" } },
}

