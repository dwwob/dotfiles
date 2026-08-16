return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',
    event = "InsertEnter",

    config = function()
      local blink = require('blink.cmp')
      
      blink.setup({
        keymap = { preset = 'default' },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = 'mono'
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
      })

      -- Pass blink parameters natively into every language server globally
      vim.lsp.config("*", {
        capabilities = blink.get_lsp_capabilities()
      })
    end
  }
}

