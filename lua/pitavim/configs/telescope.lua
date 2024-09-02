require('telescope').setup {
  defaults = {
    prompt_prefix = ' 🔭 ',
    entry_prefix = "○ ",
    selection_caret = ' ╰┈➤ ',
    path_display = { 'truncate' },
    file_ignore_patterns = {
      'dist',
      'target',
      'node_modules',
      'pack/plugins',
    },
    layout_config = {
      horizontal = {
        display = function(entry, row, col)
          -- Custom logic to determine display based on entry position
          if row < entry.selection_row then
            return "○ " .. entry.value -- Symbol for items above the selected one
          else
            return entry.value -- Default display for other items
          end
        end,
      },
    }, },
  pickers = {
    find_files = {
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
require('telescope').load_extension 'fzf'
