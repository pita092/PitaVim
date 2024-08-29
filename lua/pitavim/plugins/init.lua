return {
<<<<<<< HEAD
    "nvim-tree/nvim-tree.lua",
    {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "nvchad.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
    }
=======
  'nvim-lualine/lualine.nvim',
}
>>>>>>> 57f1bef40d110bc2c46793dd0854717a6af5da3f
