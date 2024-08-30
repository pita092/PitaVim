local db = require('dashboard')
local image = require('image')

db.setup({
  theme = 'doom',
  config = {
    header = {
      -- This function will be called when the dashboard is shown
      type = "text",
      val = function()
        -- Display the image
        image.from_file("~/Downloads/doof.png", {
          width = 40,
          height = 20,
        })
        -- Return an empty table for the header
        return {}
      end,
    },
    -- Rest of your dashboard configuration...
  }
})

