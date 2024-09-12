local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local chafa = require("chafa")

-- Function to display image
local function display_image()
  local image_path = "/path/to/your/image.png"
  local width = vim.api.nvim_win_get_width(0)
  local height = 20 -- Adjust this value as needed

  return chafa.render(image_path, {
    width = width,
    height = height,
  })
end

-- Set header (you can keep your ASCII art or replace it with the image)
dashboard.section.header.val = {
  " ",
  " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  " ",
}

-- Add image section
dashboard.section.image = {
  type = "terminal",
  command = display_image,
  width = 80,
  height = 20,
  opts = {
    redraw = true,
    window_config = {},
  },
}

-- Set menu
dashboard.section.buttons.val = {
  dashboard.button("e", " > New File", "<cmd>ene<CR>"),
  dashboard.button("SPC ee", " > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
  dashboard.button("SPC ff", " > Find File", "<cmd>Telescope find_files<CR>"),
  dashboard.button("SPC fs", " > Find Word", "<cmd>Telescope live_grep<CR>"),
  dashboard.button("SPC wr", " > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
  dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
}

-- Set layout
dashboard.config.layout = {
  { type = "padding", val = 2 },
  dashboard.section.header,
  { type = "padding", val = 2 },
  dashboard.section.image,
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  { type = "padding", val = 1 },
}

-- Send config to alpha
alpha.setup(dashboard.config)

-- Disable folding on alpha buffer
vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
