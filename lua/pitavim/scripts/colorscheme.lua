local M = {}

M.colorscheme = "default" -- Default colorscheme

M.set_colorscheme = function(name)
  M.colorscheme = name
  vim.cmd("colorscheme " .. name)
end

M.load_colorscheme = function()
  vim.cmd("colorscheme " .. M.colorscheme)
end

return M

