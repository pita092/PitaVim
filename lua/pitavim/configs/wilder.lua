-- local wilder = require("wilder")
-- wilder.setup({ modes = { ":", "/", "?" } })
--
-- -- Disable Python remote plugin for better performance
-- wilder.set_option("use_python_remote_plugin", 0)
--
-- -- Enable fuzzy matching
-- wilder.set_option("pipeline", {
-- 	wilder.branch(
-- 		wilder.cmdline_pipeline({
-- 			fuzzy = 1,
-- 			set_pcre2_pattern = 1,
-- 		}),
-- 		wilder.vim_search_pipeline()
-- 	),
-- })
--
-- -- Create custom highlight groups
-- vim.api.nvim_set_hl(0, "WilderPopupBorder", { fg = "#fbf1c7", bg = "NONE" })
-- vim.api.nvim_set_hl(0, "WilderPopupSelected", { fg = "#282828", bg = "#fbf1c7" })
-- vim.api.nvim_set_hl(0, "WilderPopupNormal", { fg = "#fbf1c7", bg = "NONE" })
--
-- -- Configure renderer with borders and custom highlights
-- local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
-- 	highlighter = {
-- 		wilder.lua_pcre2_highlighter(), -- requires `luarocks install pcre2`
-- 		wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
-- 		-- at https://github.com/romgrk/fzy-lua-native
-- 	},
-- 	highlights = {
-- 		accent = wilder.make_hl(
-- 			"WilderAccent",
-- 			"Pmenu",
-- 			{ { a = 1 }, { a = 1 }, { foreground = "#b8bb26" }, { background = "NONE" } }
-- 		),
-- 		border = "WilderPopupBorder", -- use our custom border highlight
-- 		default = "WilderPopupNormal", -- use our custom normal highlight
-- 		selected = "WilderPopupSelected", -- use our custom selected highlight
-- 	},
-- 	border = "single",
-- 	pumblend = 0, -- Set to 0 to disable transparency
-- 	left = { " ", wilder.popupmenu_devicons() },
-- 	right = { " ", wilder.popupmenu_scrollbar() },
-- 	empty_message = wilder.popupmenu_empty_message_with_spinner(),
-- 	max_height = "50%", -- max height of the popup
-- 	min_height = 0, -- set to the same as 'max_height' for a fixed height window
-- 	prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
-- 	reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
-- }))
--
-- wilder.set_option(
-- 	"renderer",
-- 	wilder.popupmenu_renderer({
-- 		-- highlighter applies highlighting to the candidates
-- 		highlighter = wilder.basic_highlighter(),
-- 		separator = " · ",
-- 		left = { " ", wilder.popupmenu_devicons() },
-- 		right = { " ", wilder.wildmenu_index() },
--
-- 		highlights = {
-- 			highlights = {
-- 				border = "Normal",
-- 			},
-- 			border = "single",
-- 		},
-- 	})
-- -- )

local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
-- Disable Python remote plugin
wilder.set_option("use_python_remote_plugin", 0)

wilder.set_option("pipeline", {
	wilder.branch(
		wilder.cmdline_pipeline({
			fuzzy = 1,
			fuzzy_filter = wilder.lua_fzy_filter(),
		}),
		wilder.vim_search_pipeline()
	),
})

wilder.set_option(
	"renderer",
	wilder.renderer_mux({
		[":"] = wilder.popupmenu_renderer({
			highlighter = wilder.lua_fzy_highlighter(),
			left = {
				" ",
				wilder.popupmenu_devicons(),
			},
			right = {
				" ",
				wilder.popupmenu_scrollbar(),
			},
		}),
		["/"] = wilder.wildmenu_renderer({
			highlighter = wilder.lua_fzy_highlighter(),
		}),
	})
)
