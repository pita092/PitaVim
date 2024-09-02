require('telescope').setup {

  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.8,
      height = 0.8,
      preview_cutoff = 120,
    },
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
  },
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

vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE", fg = "#fbf1c7" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "NONE", fg = "#1d2021" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "NONE", fg = "#1d2021" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "NONE", fg = "#fbf1c7" })
