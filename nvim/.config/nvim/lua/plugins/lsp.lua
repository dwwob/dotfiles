return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Establish default visual mapping shortcuts when any server mounts
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("gd", vim.lsp.buf.definition, "Go to Definition")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        end,
      })

      -- Direct native registration: No wrappers, no loops, zero failure conditions
      vim.lsp.enable("html")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("cssls")
    end,
  }
}

