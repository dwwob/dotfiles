-- ~/.config/nvim/lua/plugins/blink.lua
return {
  "saghen/blink.cmp",
  version = "*", -- Downloads pre-compiled native binaries
  opts = {
    keymap = { preset = "default" },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
  opts_extend = { "sources.default" }
}


-- return {
--   {
--     'saghen/blink.cmp',
--     -- Use a release tag to download pre-built binaries
--     version = '1.*',
--     dependencies = { 'rafamadriz/friendly-snippets' },
--     opts = {
--       -- 'default' for mappings similar to cmp-tab-complete
--       -- 'super-tab' for tab to accept
--       keymap = { preset = 'default' },
--       appearance = {
--         -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
--         nerd_font_variant = 'mono'
--       },
--       sources = {
--         default = { 'lsp', 'path', 'snippets', 'buffer' },
--       },
--     },
--     opts_extend = { "sources.default" }
--   }
-- }
--
