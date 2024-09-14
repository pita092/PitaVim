local alpha = require("alpha")
require("alpha.term")

local terminal = {
  type = "terminal",
  command = vim.fn.expand("$HOME") .. "/.config/nvim/sponge.sh",
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
