return {
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end
  },
  {
    'echasnovski/mini.nvim',
    version = false,
    event = "VeryLazy",
    config = function()
      return require("pitavim.configs.mini")
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
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
      config = function()
        return require("pitavim.configs.lsp")
      end
    },
  },
  {
    {
      "nvim-telescope/telescope.nvim",
      event = "BufReadPre",
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
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
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
    event ="BufReadPre",
    priority = 1000,
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
