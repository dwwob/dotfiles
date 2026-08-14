return 
{
  "windwp/nvim-ts-autotag",
  ft = { "html", "javascript", "typescript", "tsx", "xml", "vue" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}

