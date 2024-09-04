require("themery").setup({
  themes = {
    {
      name = "Gruvbox dark",
      colorscheme = "gruvbox",
      before = [[
      -- All this block will be executed before apply "set colorscheme"
      vim.opt.background = "dark"
    ]],
    },
    {
      name = "Gruvbox light",
      colorscheme = "gruvbox",
      before = [[
      transparent_mode = true
    ]],
    },
  },
})
