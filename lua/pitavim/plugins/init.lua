return {
{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
vim.cmd[[colorscheme tokyonight]]
  end 
},
{
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
},
{

    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
    return require("pitavim.configs.lsp")
    end 
},

}
