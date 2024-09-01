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
    lazy = false,
    config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()
    end ,
},
{

    "neovim/nvim-lspconfig",
    "VonHeikemen/lsp-zero.nvim",
    event = "VimEnter",
    config = function()
    return require("pitavim.configs.lsp")
    end 
},

}
