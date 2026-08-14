-- 1. Plugin Installation
return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'ray-x/cmp-treesitter', -- Add the Tree-sitter source dependency
    },
    config = function()
      local cmp = require('cmp')
      
      cmp.setup({
        -- 2. Register the source in your configuration
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },  -- Primary LSP completions
          { name = 'treesitter' }, -- Tree-sitter completions
          { name = 'buffer' },     -- Text from current buffer
        }),
      })
    end,
  }
}

