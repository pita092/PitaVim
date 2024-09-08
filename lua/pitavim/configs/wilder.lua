local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })

wilder.set_option("pipeline", {
  wilder.branch(wilder.cmdline_pipeline(), wilder.search_pipeline()),
})

wilder.set_option(
  "renderer",
  wilder.wildmenu_renderer({
    highlighter = wilder.basic_highlighter(),
  })
)
wilder.set_option(
  "renderer",
  wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
    pumblend = 20,
    highlighter = {
      wilder.lua_pcre2_highlighter(), -- requires `luarocks install pcre2`
      wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
      -- at https://github.com/romgrk/fzy-lua-native
    },
    highlights = {
      accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
    },

    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
  }))
)
