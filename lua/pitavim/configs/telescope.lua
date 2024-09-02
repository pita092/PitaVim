local normal_hl = vim.api.nvim_get_hl_by_name('Normal', true)

local purple1 = '#333352'
local purple2 = '#232338'
local purple3 = '#12121c'
local red1 = '#ba3648'
local green1 = '#37ad39'
local blue1 = '#0985de'

----------------------------------------------------------------------
--                              Prompt                              --
----------------------------------------------------------------------
vim.api.nvim_set_hl(0, 'TelescopePromptBorder', {
  fg = purple3,
  bg = purple3,
})

vim.api.nvim_set_hl(0, 'TelescopePromptNormal', {
  fg = normal_hl.foreground,
  bg = purple3,
})

vim.api.nvim_set_hl(0, 'TelescopePromptTitle', {
  fg = normal_hl.foreground,
  bg = red1,
})

vim.api.nvim_set_hl(0, 'TelescopePromptCounter', {
  fg = red1,
  bg = purple3,
})

vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', {
  fg = red1,
  bg = purple3,
})

----------------------------------------------------------------------
--                              Result                              --
----------------------------------------------------------------------
vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', {
  fg = purple2,
  bg = purple2,
})

vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', {
  fg = normal_hl.foreground,
  bg = purple2,
})

vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', {
  fg = normal_hl.foreground,
  bg = blue1,
})

vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', {
  fg = blue1,
  bg = vim.api.nvim_get_hl_by_name('TelescopeSelection', true).background,
})

----------------------------------------------------------------------
--                             Preview                              --
----------------------------------------------------------------------

vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', {
  fg = purple1,
  bg = purple1,
})

vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', {
  fg = normal_hl.foreground,
  bg = purple1,
})

vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', {
  fg = normal_hl.foreground,
  bg = green1,
})



require('telescope').setup {

  defaults = {
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '   ',
    path_display = { 'truncate' },
    file_ignore_patterns = {
      'dist',
      'target',
      'node_modules',
      'pack/plugins',
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
