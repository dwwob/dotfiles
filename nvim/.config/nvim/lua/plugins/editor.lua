-- ~/.config/nvim/lua/plugins/editor.lua
return {
  -- =========================================================================
  -- 1. TELESCOPE.NVIM (FUZZY FINDER)
  -- =========================================================================
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    },
  },

  -- =========================================================================
  -- 2. WHICH-KEY.NVIM (KEYBINDING VISUALIZER)
  -- =========================================================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>f", group = "Find / Telescope" },
        { "<leader>g", group = "Git / Preview" },
      },
    },
  },

  -- =========================================================================
  -- 3. GOTO-PREVIEW (FLOATING DEFINITION WINDOWS)
  -- =========================================================================
  {
    "rmagatti/goto-preview",
    event = "LspAttach",
    keys = {
      { "<leader>gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", desc = "Preview Definition" },
      { "<leader>gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<cr>", desc = "Preview Type Definition" },
      { "<leader>gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>", desc = "Preview Implementation" },
      { "<leader>gpr", "<cmd>lua require('goto-preview').goto_preview_references()<cr>", desc = "Preview References" },
      { "<leader>gpc", "<cmd>lua require('goto-preview').close_all_win()<cr>", desc = "Close All Previews" },
    },
    opts = {
      width = 120,
      height = 25,
      default_mappings = false, -- Managed explicitly above via keys table
      debug = false,
      opacity = nil,
      post_open_hook = nil,
    },
  },

  -- =========================================================================
  -- 4. VIM-FUGITIVE (GIT WRAPPER)
  -- =========================================================================
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status Panel" },
    },
  },

  -- =========================================================================
  -- 5. VIM-GITGUTTER (SIGN COLUMN DIFF INDICATORS)
  -- =========================================================================
  {
    "airblade/vim-gitgutter",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      -- Keep updates snappy when text changes
      vim.g.gitgutter_diff_base = "HEAD"
      vim.opt.updatetime = 100
    end,
  },
}

