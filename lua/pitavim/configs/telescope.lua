local builtin = require('telescope.builtin')

local function vsp(func)
  return function()
    func({
      jump_type = 'vsplit',
    })
  end
end

wk.register({
  name = 'Finder',
  n = { builtin.grep_string, 'Find word under cursor' },
  e = { builtin.find_files, 'Find files' },
  t = { builtin.live_grep, 'Find text' },
  i = { builtin.buffers, 'Find buffers' },
  s = { builtin.current_buffer_fuzzy_find, 'Find line' },
  o = { builtin.resume, 'Find last search' },
}, { prefix = '<leader>n' })

local reg_lsp_keymaps = function(buffer)
  end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(arg)
    local buffer = arg.buf
    reg_lsp_keymaps(buffer)
  end,
  group = vim.api.nvim_create_augroup('Telescope lsp keymaps', {}),
})

local telescope = require('telescope')
local action = require('telescope.actions')

telescope.setup({
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

    mappings = {
      i = {
        ['<C-h>'] = action.which_key,
        ['<C-n>'] = action.move_selection_next,
        ['<C-e>'] = action.move_selection_previous,
        ['<C-c>'] = action.close,
        ['<esc>'] = action.close,
      },
    },
  },
  extensions = {
    recent_files = {
      only_cwd = true,
    },
  },
})

telescope.load_extension('fzf')
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
