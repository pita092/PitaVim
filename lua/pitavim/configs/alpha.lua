-- alpha_config.lua

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local chafa = require("chafa")

-- Function to display image using chafa
local function display_image()
  local image_path = "/mnt/c/users/itaym/Downloads/9740-3942146447(1).png" -- Replace with your image path
  local width = vim.o.columns
  local height = 20                                                       -- Adjust as needed

  return {
    type = "terminal",
    command = function()
      vim.defer_fn(function()
        chafa.render(image_path, {
          width = width,
          height = height,
        })
      end, 100)
      return ""
    end,
    width = width,
    height = height,
    opts = {
      redraw = true,
      window_config = {},
    },
  }
end

-- Set up the header (using chafa image display)
dashboard.section.header.val = display_image()

-- Customize buttons
dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
  dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
  dashboard.button("s", "  Settings", ":e $MYVIMRC <CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- Customize footer
dashboard.section.footer.val = "Happy coding!"

-- Set up the layout
local config = {
  layout = {
    { type = "padding", val = 2 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
  },
  opts = {
    margin = 5,
    noautocmd = true,
  },
}

-- Set up alpha
alpha.setup(config)

-- Configure chafa
chafa.setup({
  render = {
    min_padding = 5,
    show_label = true,
  },
  events = {
    update_on_nvim_resize = true,
  },
})

-- Automatically open alpha when Neovim starts with no arguments
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
      require("alpha").start()
    end
  end,
})

-- Optional: Add a command to manually refresh alpha
vim.api.nvim_create_user_command("AlphaRefresh", function()
  require("alpha").redraw()
end, {})
