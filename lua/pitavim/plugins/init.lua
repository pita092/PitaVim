return {
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = "UIEnter",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function ()
    return require("pitavim.configs.barbecue")
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      return require("pitavim.configs.none-ls")
    end,
  },
  {
    {
      "williamboman/mason.nvim",
      cmd = { "MasonInstall", "Mason" },
      opts = {},
    },
    {
      "williamboman/mason-lspconfig.nvim",
      cmd = { "Mason", "Mason" },
    },
    {
      "neovim/nvim-lspconfig",
      event = "BufReadPre",
    },
    {
      "j-hui/fidget.nvim",
      event = "BufReadPre",
      config = function()
        return require("pitavim.configs.fidget")
      end,
    },
  },
  {
    {
      "nvim-telescope/telescope.nvim",
      cmd = { "Telescope" },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
      },
      config = function()
        return require("pitavim.configs.telescope")
      end,
    },
    {
      "nvim-lua/popup.nvim",
      cmd = "Telescope",
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      cmd = "Telescope"
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "BufReadPre",
    priority = 100,
    dependencies = {
      "neovim/nvim-lspconfig",
      {
        "hrsh7th/cmp-nvim-lsp",
        event = "InsertEnter",
        {
          "L3MON4D3/LuaSnip",
          build = (function()
            if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
              return
            end
            return "make install_jsregexp"
          end)(),
          dependencies = {
            { "onsails/lspkind.nvim" },

            "hrsh7th/nvim-cmp",
            {
              "rafamadriz/friendly-snippets",
              config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
              end,
            },
          },
        },
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "windwp/nvim-autopairs",
        "VonHeikemen/lsp-zero.nvim",
      },
    },
    config = function()
      return require("pitavim.configs.cmp")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    event = "UIEnter",
    priority = 1000,
    config = true,
    config = function()
      return require("pitavim.configs.gruvbox")
    end,
  },
  {

    "nvim-neo-tree/neo-tree.nvim",
    name = "neotree",
    cmd = "Neotree",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      config = function()
        return require("pitavim.configs.neotree")
      end,
    },
  },
  {
    "NvChad/nvterm",
    event = "BufReadPre",
    config = function()
      return require("pitavim.configs.nvterm")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require("pitavim.configs.treesitter")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
