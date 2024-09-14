require("neo-tree").setup({
  close_if_last_window = false,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  sources = { "filesystem", "buffers", "git_status" },
  source_selector = {
    winbar = true,
    statusline = false,
    content_layout = "center",
    tabs_layout = "equal",
    sources = {
      { source = "filesystem", display_name = "Files" },
      { source = "buffers",    display_name = "Buffers" },
      { source = "git_status", display_name = "Git" },
    },
  },
  default_component_configs = {
    -- Your existing default_component_configs here
  },
  window = {
    position = "left",
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      -- Your existing mappings here
      ["<"] = "prev_source",
      [">"] = "next_source",
    },
  },
  filesystem = {
    -- Your existing filesystem configuration here
  },
  buffers = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },
    group_empty_dirs = true,
    show_unloaded = true,
  },
  git_status = {
    window = {
      position = "float",
      -- Your existing git_status mappings here
    },
  },
})

-- Add these key mappings outside of the setup function
vim.keymap.set("n", "<leader>e", ":Neotree filesystem<CR>", { silent = true })
vim.keymap.set("n", "<leader>b", ":Neotree buffers<CR>", { silent = true })
vim.keymap.set("n", "<leader>g", ":Neotree git_status<CR>", { silent = true })

-- Your existing command to reveal Neotree
vim.cmd([[nnoremap \ :Neotree reveal]])
