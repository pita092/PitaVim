-- require('lualine').setup {
--   options = {
--     icons_enabled = true,
--     theme = 'gruvbox',
--     component_separators = { left = '', right = '' },
--     section_separators = { left = '', right = '' },
--     disabled_filetypes = {
--       statusline = {},
--       winbar = {},
--     },
--     ignore_focus = {},
--     always_divide_middle = true,
--     globalstatus = false,
--     refresh = {
--       statusline = 1000,
--       tabline = 1000,
--       winbar = 1000,
--     }
--   },
--   sections = {
--     lualine_a = { 'mode' },
--     lualine_b = { 'branch', 'diff', 'diagnostics' },
--     lualine_c = { 'filename' },
--     lualine_x = { 'encoding', 'fileformat', 'filetype' },
--     lualine_y = { 'progress' },
--     lualine_z = {},
--   },
--   inactive_sections = {
--     lualine_a = {},
--     lualine_b = {},
--     lualine_c = { 'filename' },
--     lualine_x = { 'location' },
--     lualine_y = {},
--     lualine_z = {}
--   },
--   tabline = {},
--   winbar = {},
--   inactive_winbar = {},
--   extensions = {}
-- }

local custom_theme = {
  normal = {
    a = { fg = "#000000", bg = "#ffffff" },
    b = { fg = "#ffffff", bg = "#000000" },
    c = { fg = "#ffffff", bg = "#000000" },
  },
  -- Add more modes (insert, visual, etc.) as needed
}

require("lualine").setup({
  options = {
    theme = custom_theme,
    -- other options...
  },
  -- sections configuration...
})

require("lualine").setup({
  options = {
    theme = "gruvbox", -- or any other theme you prefer
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", symbols = { added = " ", modified = "柳", removed = " " } },
    },
    lualine_c = {
      { "filename", file_status = true, path = 1 },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
    },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
})
