-- ~/.config/nvim/lua/plugins/ui.lua
return {
  -- =========================================================================
  -- 1. COLOR.LUA & LINE NUMBER HIGHLIGHTS
  -- =========================================================================
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])

      -- Enhances line number visibility for hybrid relative numbering
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#7aa2f7", bold = true })       -- Active line index
      vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#add8e6", bold = false })  -- Lines above
      vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#add8e6", bold = false })  -- Lines below
    end,
  },

  -- =========================================================================
  -- 2. LUALINE.LUA & ONELINER.LUA (STATUSLINE WITH GIT & LSP TRACKING)
  -- =========================================================================
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "lazy", "mason" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        -- Displays real-time Git status metrics (branch name, edits, deletions)
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } }, -- Shows relative file paths
        lualine_x = {
          -- Custom components to query active Neovim LSP clients
          {
            function()
              local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
              if #buf_clients == 0 then
                return "No LSP"
              end
              
              local client_names = {}
              for _, client in ipairs(buf_clients) do
                table.insert(client_names, client.name)
              end
              return "LSP: " .. table.concat(client_names, ", ")
            end,
            icon = "",
            color = { fg = "#7aa2f7", gui = "bold" },
          },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- =========================================================================
  -- 3. INDENTBLANKLINE.LUA (STRUCTURAL TRACKING)
  -- =========================================================================
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        highlight = { "Function", "Label" },
      },
    },
  },
}

