local db = require('dashboard')

db.setup({
  theme = 'doom',
  config = {
    header = {}, -- We'll set this later
    center = {
      {icon = ' ', desc = 'New file', action = 'enew'},
      {icon = ' ', desc = 'Find file', action = 'Telescope find_files'},
      {icon = ' ', desc = 'Recent files', action = 'Telescope oldfiles'},
      {icon = ' ', desc = 'Exit', action = 'quit'},
    },
    footer = {} -- Optionally add a footer
  }
})

