return {
	{
  {
    'williamboman/mason.nvim',
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
  },
  { 'j-hui/fidget.nvim', opts = {} },
  { 'j-hui/fidget.nvim', opts = {} },
},
{
	{
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-media-files.nvim',
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
	config = function()
	return require("pitavim.configs.telescope")
	end,
  },
{ 'nvim-lua/popup.nvim' },
  {
    'nvim-telescope/telescope-ui-select.nvim',
  },
	{
  'nvim-telescope/telescope-fzf-native.nvim',
  build = 'make',
  dependencies = {'nvim-telescope/telescope.nvim'}
	}
},
  {
    'hrsh7th/nvim-cmp',
    lazy = false,
    priority = 100,
    dependencies = {
      'neovim/nvim-lspconfig',
      {
        'hrsh7th/cmp-nvim-lsp',
        event = 'InsertEnter',
        {
          'L3MON4D3/LuaSnip',
          build = (function()
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
              return
            end
            return 'make install_jsregexp'
          end)(),
          dependencies = {
            { 'onsails/lspkind.nvim' },

            'hrsh7th/nvim-cmp',
            {
              'rafamadriz/friendly-snippets',
              config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
              end,
            },
          },
        },
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/nvim-cmp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        'windwp/nvim-autopairs',
	'VonHeikemen/lsp-zero.nvim',
      },
    },
    config = function()
    return require "pitavim.configs.cmp"	
    end,
  },
{ "ellisonleao/gruvbox.nvim",
	priority = 1000 ,
	config = true,
	config = function()
	return require "pitavim.configs.gruvbox"
	end,
	},
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
