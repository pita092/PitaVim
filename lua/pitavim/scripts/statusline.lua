local M = {}

-- Helper function to get Git status
local function get_git_status()
  local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
  if branch ~= "" then
    return " " .. branch
  end
  return ""
end

-- Helper function to get LSP diagnostics
local function get_lsp_diagnostics()
  local diagnostics = vim.diagnostic.get(0)
  local count = { errors = 0, warnings = 0, info = 0, hints = 0 }
  for _, diagnostic in ipairs(diagnostics) do
    if diagnostic.severity == vim.diagnostic.severity.ERROR then
      count.errors = count.errors + 1
    elseif diagnostic.severity == vim.diagnostic.severity.WARN then
      count.warnings = count.warnings + 1
    elseif diagnostic.severity == vim.diagnostic.severity.INFO then
      count.info = count.info + 1
    elseif diagnostic.severity == vim.diagnostic.severity.HINT then
      count.hints = count.hints + 1
    end
  end
  return string.format("E:%d W:%d I:%d H:%d", count.errors, count.warnings, count.info, count.hints)
end

-- Helper function to get file icon
local function get_file_icon()
  local filename = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local icon = require("nvim-web-devicons").get_icon(filename, extension)
  if icon then
    return icon .. " "
  else
    return ""
  end
end

-- Main statusline function
function M.statusline()
  local mode = vim.api.nvim_get_mode().mode
  local filename = vim.fn.expand("%:t")
  local filetype = vim.bo.filetype
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local git = get_git_status()
  local diagnostics = get_lsp_diagnostics()
  local icon = get_file_icon()

  -- Mode map for better readability
  local mode_map = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    [""] = "V-BLOCK",
    c = "COMMAND",
    R = "REPLACE",
    t = "TERMINAL",
  }

  local mode_text = mode_map[mode] or mode

  return table.concat({
    "%#StatusLineMode#",
    string.format(" %s ", mode_text),
    "%#StatusLine#",
    string.format(" %s%s", icon, filename),
    " | ",
    filetype,
    git,
    " | ",
    diagnostics,
    "%=", -- Right align
    string.format("%s:%s ", line, col),
    vim.bo.modified and "[+] " or "   ",
  })
end

-- Function to set up the statusline
function M.setup()
  -- Set the statusline
  vim.o.statusline = "%!v:lua.require'statusline'.statusline()"

  -- Define highlight groups
  vim.cmd([[
    highlight StatusLineMode guibg=##1d2021 guifg=#fabd2f gui=bold
    highlight StatusLine guibg=#fbf1c7 guifg=#7c6f64
  ]])
end

return M
