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

local function set_telescope_colors()
	local color = {
		bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg#"),
		fg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "fg#"),
		selection = vim.fn.synIDattr(vim.fn.hlID("Visual"), "bg#"),
		border = vim.fn.synIDattr(vim.fn.hlID("FloatBorder"), "fg#"),
		prompt = vim.fn.synIDattr(vim.fn.hlID("Keyword"), "fg#"),
		match = vim.fn.synIDattr(vim.fn.hlID("Search"), "fg#"),
	}

	local highlights = {
		TelescopePromptBorder = { bg = color.bg, fg = color.border },
		TelescopePromptNormal = { bg = color.bg },
		TelescopeNormal = { bg = color.bg, fg = color.fg },
		TelescopeSelection = { bg = color.selection },
		TelescopePromptPrefix = { fg = color.prompt },
		TelescopeMatching = { fg = color.match },
		Pmenu = { bg = color.bg },
		TelescopePromptTitle = { bg = color.bg, fg = color.fg },
		TelescopeBorder = { fg = color.border, bg = color.border },
		NeoTreeTitleBar = { bg = color.fg, fg = color.bg },
		DiagnosticVirtualTextError = { bg = color.bg, fg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticError"), "fg#") },
		DiagnosticVirtualTextWarn = { bg = color.bg, fg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticWarn"), "fg#") },
		DiagnosticVirtualTextInfo = { bg = color.bg, fg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticInfo"), "fg#") },
		DiagnosticVirtualTextHint = { bg = color.bg, fg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticHint"), "fg#") },
	}

	for group, color in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, color)
	end
end
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		set_telescope_colors()
	end,
})

-- Telescope highlight groups
local highlights = {
	TelescopeBorder = { fg = colors.bg1, bg = colors.bg1 },
	TelescopePromptBorder = { fg = colors.bg2, bg = colors.bg2 },
	TelescopePromptNormal = { fg = colors.fg1, bg = colors.gray },
	TelescopePromptPrefix = { fg = colors.orange, bg = colors.bg2 },
	TelescopePromptTitle = { fg = colors.bg0, bg = colors.fg1 },
	TelescopePreviewTitle = { fg = colors.fg1, bg = colors.green },
	TelescopeResultsTitle = { fg = colors.bg0, bg = colors.gray },
	TelescopeSelection = { fg = colors.fg1, bg = colors.bg2 },
	TelescopeSelectionCaret = { fg = colors.orange, bg = colors.bg2 },
	TelescopeResultsDiffAdd = { fg = colors.green },
	TelescopeResultsDiffChange = { fg = colors.yellow },
	TelescopeResultsDiffDelete = { fg = colors.red },
}

-- Apply highlights
for hl_group, col in pairs(highlights) do
	vim.api.nvim_set_hl(0, hl_group, col)
end

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
--   highlight Pmenu guibg=#3c3836
--   highlight 	TelescopePromptTitle guibg=#504945
--   highlight 	TelescopePromptTitle guifg=#fbf1c7
--   highlight 	TelescopeBorder guifg=#fbf1c7
--   highlight 	TelescopeBorder guibg=#fbf1c7
--   highlight NeoTreeTitleBar guibg = #fbf1c7
--   highlight NeoTreeTitleBar guifg = #3c3836
--   highlight DiagnosticVirtualTextError guibg = #504945
--   highlight DiagnosticVirtualTextError guifg =#cc241d
--   highlight DiagnosticVirtualTextWarn guibg = #504945
--   highlight DiagnosticVirtualTextWarn guifg = #fabd2f
--   highlight DiagnosticVirtualTextInfo guibg = #504945
--   highlight DiagnosticVirtualTextInfo guifg = #689d6a
--   highlight DiagnosticVirtualTextHint guibg = #504945
--   highlight diagnosticvirtualtexthint guifg = #b57614
--
--   ]])
