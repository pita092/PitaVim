return {
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    config = function()
      return require("pitavim.configs.gitsigns")
    end,
  },
  {
    "nvim-lua/plenary.nvim",
    event = "VimEnter",
  },
  -- {
  --   "echasnovski/mini.nvim",
  --   version = false,
  --   event = "VeryLazy",
  --   config = function()
  --     return require("pitavim.configs.mini")
  --   end,
  -- },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      return require("pitavim.configs.lualine")
    end,
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    event = "VeryLazy",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    main = "ibl",
    opts = {},
  },
  {
    "nvimtools/none-ls.nvim",
    event = "BufReadPre",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
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
      config = function()
        return require("pitavim.configs.lsp")
      end,
    },
  },
  {
    {
      "nvim-telescope/telescope.nvim",
      lazy = true,
      cmd = "Telescope",
      dependencies = {
        "nvim-telescope/telescope-media-files.nvim",
        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
      },
      config = function()
        return require("pitavim.configs.telescope")
      end,
    },
    {
      "nvim-lua/popup.nvim",
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    priority = 100,
    dependencies = {
      {
        "VonHeikemen/lsp-zero.nvim",
        "onsails/lspkind.nvim",
      },
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require("pitavim.configs.snippets")
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "lukas-reineke/cmp-under-comparator",
      },
    },
    config = function()
      return require("pitavim.configs.cmp")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      return require("pitavim.configs.gruvbox")
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      return require("pitavim.configs.colorizer")
    end,
  },
  {

    "nvim-neo-tree/neo-tree.nvim",
    name = "neotree",
    cmd = "Neotree",
    branch = "v3.x",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      config = function()
        return require("pitavim.configs.neotree")
      end,
    },
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
      return require("pitavim.configs.oil")
    end,
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
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require("pitavim.configs.treesitter")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
