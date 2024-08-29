require('telescope').setup {
  pickers = {
    find_files = {
      theme = 'dropdown',
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
    media_files = {
      filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
      find_cmd = 'rg',
    },
  },
  cond = function()
    return vim.fn.executable 'make' == 1
  end,
  winblend = 30,
}
require('telescope').load_extension 'ui-select'
require('telescope').load_extension('fzf')
