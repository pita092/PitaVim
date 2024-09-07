-- require("lualine").setup({
-- 	options = {
-- 		icons_enabled = true,
-- 		theme = "gruvbox",
-- 		component_separators = { left = "", right = "" },
-- 		section_separators = { left = "", right = "" },
-- 		disabled_filetypes = {
-- 			statusline = {},
-- 			winbar = {},
-- 			disabled_filetypes = { "NvimTree", "neo-tree" },
-- 		},
-- 		ignore_focus = {},
-- 		always_divide_middle = true,
-- 		globalstatus = false,
-- 		refresh = {
-- 			statusline = 1000,
-- 			tabline = 1000,
-- 			winbar = 1000,
-- 		},
-- 	},
-- 	sections = {
-- 		lualine_a = { "mode" },
-- 		lualine_b = { "branch", "diff", "diagnostics" },
-- 		lualine_c = { "filename" },
-- 		lualine_x = { "encoding", "filetype" },
-- 		lualine_y = { "" },
-- 		lualine_z = {},
-- 	},
-- 	inactive_sections = {
-- 		lualine_a = {},
-- 		lualine_b = {},
-- 		lualine_c = { "filename" },
-- 		lualine_x = { "location" },
-- 		lualine_y = {},
-- 		lualine_z = {},
-- 	},
-- 	tabline = {},
-- 	winbar = {},
-- 	inactive_winbar = {},
-- 	extensions = {},
-- })

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "gruvbox",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {
      {
        function()
          return string.rep(" ", vim.fn.winwidth(0) / 2 - 50)
        end,
      },
      "mode",
      "branch",
      "filename",
      "diagnostics",
      "filetype",
      "progress",
      {
        function()
          return string.rep(" ", vim.fn.winwidth(0) / 2 - 50)
        end,
      },
    },
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})
