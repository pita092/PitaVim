local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
wilder.set_option("pipeline", {
	wilder.branch(
		wilder.python_file_finder_pipeline({
			-- to use ripgrep : {'rg', '--files'}
			-- to use fd      : {'fd', '-tf'}
			file_command = { "find", ".", "-type", "f", "-printf", "%P\n" },
			-- to use fd      : {'fd', '-td'}
			dir_command = { "find", ".", "-type", "d", "-printf", "%P\n" },
			-- use {'cpsm_filter'} for performance, requires cpsm vim plugin
			-- found at https://github.com/nixprime/cpsm
			filters = { "fuzzy_filter", "difflib_sorter" },
		}),
		wilder.cmdline_pipeline(),
		wilder.python_search_pipeline()
	),
})
wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer({
		highlighter = wilder.basic_highlighter(),
		left = { " ", wilder.popupmenu_devicons() },
		right = { " ", wilder.popupmenu_scrollbar() },
	})
)
wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer({
		highlighter = {
			wilder.lua_pcre2_highlighter(), -- requires `luarocks install pcre2`
			wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
			-- at https://github.com/romgrk/fzy-lua-native
		},
		highlights = {
			accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#fabd2f" } }),
		},
	})
)
