-- ~/.config/nvim/lua/plugins/neotree.lua
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- clean file icon markers
      "MunifTanjim/nui.nvim",
    },
    keys = {
      -- Press Spacebar + e to toggle the tree side panel cleanly
      { "<leader>e", "<cmd>Neotree toggle filesystem left<cr>", desc = "Toggle File Explorer" },
    },
    opts = {
      filesystem = {
        follow_current_file = {
          enabled = true, -- Auto focus the tree node when swapping file tabs
        },
        filtered_items = {
          visible = true, -- Show hidden files (like .dotfiles) slightly faded out
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        width = 30, -- Set fixed layout side-panel width
        mappings = {
          ["<space>"] = "none", -- Clear space conflict bar so leader keys work inside the tree window
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            -- High-visibility indicators matching your vivid theme setup
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            renamed   = "  ",
            untracked = "",
            ignored   = "",
            unstaged  = "  ",
            staged    = "  ",
            conflict  = "",
          },
        },
      },
    },
  },
}

