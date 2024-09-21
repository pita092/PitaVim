-- vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#262626", bg = "#3c3836" })
-- vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = "#fbf1c7", bg = "#3c3836" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#282828", bg = "#282828" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#282828" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#282828", bg = "#fbf1c7" })
-- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#262626", bg = "#262626" })
-- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = "#fbf1c7", bg = "#262626" })
-- vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#282828", bg = "#fbf1c7" })
-- vim.api.nvim_set_hl(9, "TelescopePromptTitle", { fg = "#fbf1c7", bg = "#282828" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#fbf1c7", bg = "#282828" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#282828" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#282828", bg = "#fbf1c7" })

local colors = {
	bg0 = "#282828",
	bg1 = "#3c3836",
	bg2 = "#282828",
	fg1 = "#fbf1c7",
	fg4 = "#a89984",
	gray = "#928374",
	blue = "#458588",
	aqua = "#689d6a",
	purple = "#b16286",
	orange = "#d65d0e",
	red = "#cc241d",
	green = "#98971a",
	yellow = "#d79921",
}

-- Telescope highlight groups
-- local highlights = {
-- 	TelescopeBorder = { fg = colors.bg1, bg = colors.bg1 },
-- 	TelescopePromptBorder = { fg = colors.bg2, bg = colors.bg2 },
-- 	TelescopePromptNormal = { fg = colors.fg1, bg = colors.gray },
-- 	TelescopePromptPrefix = { fg = colors.orange, bg = colors.bg2 },
-- 	TelescopePromptTitle = { fg = colors.bg0, bg = colors.fg1 },
-- 	TelescopePreviewTitle = { fg = colors.fg1, bg = colors.green },
-- 	TelescopeResultsTitle = { fg = colors.bg0, bg = colors.gray },
-- 	TelescopeSelection = { fg = colors.fg1, bg = colors.bg2 },
-- 	TelescopeSelectionCaret = { fg = colors.orange, bg = colors.bg2 },
-- 	TelescopeResultsDiffAdd = { fg = colors.green },
-- 	TelescopeResultsDiffChange = { fg = colors.yellow },
-- 	TelescopeResultsDiffDelete = { fg = colors.red },
-- }

-- Apply highlights

vim.cmd([[
  colorscheme gruvbox
  highlight Normal guibg=#282828
  ]])

-- vim.cmd([[
--   highligh  TelescopePromptBorder guibg=#504945
--   highligh  TelescopePromptBorder guifg=#504945
--   highlight TelescopePromptNormal guibg=#504945
--   highlight TelescopeNormal guibg=#3c3836
--   highlight TelescopeNormal guifg=#fbf1c7
--   highlight TelescopeSelection guibg=#7c6f64
--   highlight  TelescopePromptPrefix guifg=#b8bb26
--   highlight TelescopeMatching guifg=#fabd2f
--   highlight 	TelescopePromptTitle guibg=#504945
--   highlight 	TelescopePromptTitle guifg=#fbf1c7
--   highlight 	TelescopeBorder guifg=#fbf1c7
--   highlight 	TelescopeBorder guibg=#fbf1c7
--   highlight Pmenu guibg=#fbf1c7
--   highlight NeoTreeTitleBar guibg = #fbf1c7
--   highlight NeoTreeTitleBar guifg = #3c3836
--   highlight DiagnosticVirtualTextError guifg =#cc241d
--   highlight DiagnosticVirtualTextWarn guifg = #fabd2f
--   highlight DiagnosticVirtualTextInfo guifg = #689d6a
--   highlight diagnosticvirtualtexthint guifg = #b57614
--
--   ]])
