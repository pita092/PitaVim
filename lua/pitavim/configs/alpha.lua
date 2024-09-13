local alpha = require("alpha")
require("alpha.term")

local terminal = {
  type = "terminal",
  command = vim.fn.expand("$HOME") .. "/.config/nvim/thisisfine.sh",
  width = 46,
  height = 25,
  opts = {
    redraw = true,
    window_config = {},
  },
}

local config = {
  layout = {
    { type = "padding", val = 2 },
    terminal,
  },
  opts = {
    margin = vim.fn.max({ 2, vim.fn.floor(vim.fn.winwidth(0) / 2 - 23) }),
  },
}

alpha.setup(config)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    vim.opt.laststatus = 0
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      callback = function()
        vim.opt.laststatus = 2
      end,
    })
  end,
})
