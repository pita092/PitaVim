local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer({
		-- highlighter applies highlighting to the candidates
		highlighter = wilder.basic_highlighter(),
	})
)
wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer({
		pumblend = 20,
	})
)
wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
		highlights = {
			border = "Normal", -- highlight to use for the border
		},
		-- 'single', 'double', 'rounded' or 'solid'
		-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
		border = "rounded",
	}))
)
vim.api.nvim_set_hl(0, "WildMenu", { fg = "#fbf1c7", bg = "#282828", italic = true })
