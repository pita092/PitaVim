-- In custom/winbar.lua
local M = {}

function M.get_winbar()
  local file_name = vim.fn.expand("%:t")
  local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")

  if branch ~= "" then
    return string.format("%s   %s", file_name, branch)
  else
    return file_name
  end
end

vim.o.winbar = "%{%v:lua.require'custom.winbar'.get_winbar()%}"

return M
