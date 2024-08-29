return {
{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = true},
	{
		
    "nvim-neo-tree/neo-tree.nvim",
		name = "neotree",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
	"MunifTanjim/nui.nvim",
	 config = function()
	return require "pitavim.configs.neotree"
	end,
	    }
	},
	{
  "NvChad/nvterm",
  config = function ()
    require("nvterm").setup()
  end,
    },
    {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "pitavim.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
