local opt = vim.opt
local o = vim.o
local g = vim.g

vim.cmd 'set number'
vim.cmd 'set tabstop=2'
vim.cmd 'set softtabstop=2'
vim.cmd 'set shiftwidth=2'
vim.g.have_nerd_font = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

o.expandtab = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
--vim.opt.listchars = {tab = "» " , trail = "·", nbsp = "␣" }
vim.opt.listchars = {
  eol = '↵',
  tab = '· ',
  trail = '▸',
  extends = '❯',
  precedes = '❮',
}
vim.opt.list = true
o.updatetime = 250
vim.o.showtabline = 2
vim.opt.inccommand = 'split'
o.cursorline = false
o.cursorlineopt = "number"
vim.opt.scrolloff = 10

opt.whichwrap:append "<>[]hl"


local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#282828' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = '#282828' })
vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NeoTreeFloatNormal', { fg = '#ebdbb2', bg = '#282828' })
vim.api.nvim_set_hl(0, 'NeoTreeFloatBorder', { fg = '#ebdbb2', bg = '#282828' })
vim.api.nvim_set_hl(0, 'NeoTreeTitleBar', { fg = '#ebdbb2', bg = '#282828' })
