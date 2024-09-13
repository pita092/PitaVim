local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local example = function(opts)
  opts = opts or {}

  pickers
      .new(opts, {
        finder = finders.new_table({
          results = { "Hello", "yall" },
        }),
        sorter = conf.generic_sorter(opts),
      })
      :find()
end

example()
