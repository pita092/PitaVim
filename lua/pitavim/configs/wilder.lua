local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })

-- Disable Python remote plugin for better performance
wilder.set_option("use_python_remote_plugin", 0)

-- Enable fuzzy matching
wilder.set_option("pipeline", {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,
      set_pcre2_pattern = 1,
    }),
    wilder.vim_search_pipeline()
  ),
})

-- Enable devicons
local highlighter = wilder.highlighter_with_gradient({
  wilder.basic_highlighter(), -- or wilder.lua_fzy_highlighter(),
})

-- Configure renderer with borders
local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
  highlights = {
    border = "Normal", -- highlight to use for the border
  },
  border = "rounded",
  pumblend = 20,
  left = { " ", wilder.popupmenu_devicons() },
  right = { " ", wilder.popupmenu_scrollbar() },
}))

local wildmenu_renderer = wilder.wildmenu_renderer({
  highlighter = highlighter,
  separator = " · ",
  left = { " ", wilder.popupmenu_devicons() }, -- Changed from wildmenu_devicons to popupmenu_devicons
  right = { " ", wilder.wildmenu_index() },
})

wilder.set_option(
  "renderer",
  wilder.renderer_mux({
    [":"] = popupmenu_renderer,
    ["/"] = wildmenu_renderer,
    ["?"] = wildmenu_renderer,
  })
)
