return
{
	{
{"nvim-lua/plenary.nvim",},
{"nvim-tree/nvim-web-devicons",},
{"nvim-treesitter/nvim-treesitter",},
{"NvChad/nvim-colorizer.lua",},
{
"nvim-telescope/telescope.nvim",
},
{
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function()
    end,
  },
}	
}
