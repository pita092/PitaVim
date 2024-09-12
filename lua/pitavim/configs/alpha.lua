local alpha = require("alpha")
local chafa = require("chafa")

local function display_image()
  local image_path = "/path/to/your/image.png"
  local width = vim.api.nvim_win_get_width(0)
  local height = 20 -- Adjust this value as needed

  return chafa.render(image_path, {
    width = width,
    height = height,
  })
end

local config = {
  layout = {
    { type = "padding", val = 2 },
    {
      type = "terminal",
      command = display_image,
      width = 80,
      height = 20,
      opts = {
        redraw = true,
        window_config = {},
      },
    },
    { type = "padding", val = 2 },
    -- Add other alpha.nvim components here
  },
}

alpha.setup(config)
