local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer({
		-- highlighter applies highlighting to the candidates
		highlighter = {
			wilder.lua_pcre2_highlighter(), -- requires `luarocks install pcre2`
			wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
			-- at https://github.com/romgrk/fzy-lua-native
		},
		highlights = {
			accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#b8bb26" } }),
		},
		left = { " ", wilder.popupmenu_devicons() },
		right = { " ", wilder.popupmenu_scrollbar() },
	})
)
wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer({
		pumblend = 20,
	})
)
