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
    config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()
    end 
},
{

    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    "VonHeikemen/lsp-zero.nvim",
    config = function()
    return require("pitavim.configs.lsp")
    end 
},

}
