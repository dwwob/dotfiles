return {
  -- Snippet Engine Configuration
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Modern Completion Engine Configuration
  {
    "Saghen/blink.cmp",
    version = "*", -- Download pre-built binaries
    opts = {
      keymap = { preset = "default" }, -- Tab/S-Tab automatically handle snippet jumping
      snippets = {
        preset = "luasnip", -- Connects blink directly to luasnip
      },
      sources = {
        default = { "lsp", "snippets", "path", "buffer" },
      },
    },
  },
}

