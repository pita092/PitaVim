local mode = {
  "mode",
  fmt = function(str)
    return " " .. str
  end,
}

local filename = {
  "filename",
  file_status = true, -- displays file status (readonly status, modified status)
  path = 1,          -- 0 = just filename, 1 = relative path, 2 = absolute path
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = false,
  update_in_insert = false,
  always_visible = false,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
}

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "gruvbox",
    section_separators = { left = " ", right = " " },
    component_separators = { left = " ", right = " " },
    disabled_filetypes = { "alpha", "neo-tree" },
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { "branch" },
    lualine_c = { filename },
    lualine_x = {
      diagnostics,
      diff,
    },
    lualine_y = { "filename", "location" },
    lualine_z = { "progress" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { { "location", padding = 0 } },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "fugitive" },
})

-----
