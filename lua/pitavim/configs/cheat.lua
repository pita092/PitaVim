require('nvcheatsheet').setup({
  -- Example configuration options
  header = "My Custom Cheatsheet",
  theme = "grid", -- or "simple"
  -- Define your keymaps here
  keymaps = {
    { mode = 'n', lhs = '<leader>ff', rhs = ':Telescope find_files<CR>', desc = 'Find Files' },
    { mode = 'n', lhs = '<leader>fg', rhs = ':Telescope live_grep<CR>', desc = 'Live Grep' },
    -- Add more keymaps as needed
  },
})

