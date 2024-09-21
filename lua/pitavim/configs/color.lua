local function make_hl_table()
	local F = require("colorful.color.functional")
	local Highlight = require("colorful.highlight")

	-- use "Normal" for our base color palette. this is generally a safe bet to
	-- creating a consistent look across most themes
	local hl = Highlight("Normal")

	-- think of these colors as "swatches" on a palette. we can build these out
	-- using HSL functions to make the new colors feel consistent.
	local fg = hl.fg
	local bg = hl:map_copy("bg", F.lighten(0.02))
	local bg_dark = hl:map_copy("bg", F.lighten(-0.045))
	local dim = hl:map_copy("bg", F.lighten(0.125))
	-- use multiple groups to find accent colors; functions are usually a bit
	-- more contrasted/colorful in most colorschemes. other good choices are
	-- Keyword, String, or Constant. This function will fallback to using the
	-- value set by the Normal group if no other color was found.
	local accent = Highlight.get_fg("@function", "Function")

	-- this table will be used by `colorful.setup` to apply highlights per colorscheme.
	-- the `*` key applies to every colorscheme. if needed, lua patterns can be used
	-- as keys to apply changes to a colorscheme name that matches (such as `mytheme*`
	-- for mytheme-soft, mytheme-darker, etc.).
	return {
		-- always applied, regardless of theme name
		["*"] = {
			TelescopeNormal = { fg = fg, bg = bg_dark },
			TelescopePreviewBorder = { fg = bg_dark, bg = bg_dark },
			TelescopePreviewTitle = { fg = accent, reverse = true, bold = true },
			TelescopePromptBorder = { fg = bg, bg = bg },
			TelescopePromptCounter = { fg = dim },
			TelescopePromptNormal = { fg = fg, bg = bg },
			TelescopePromptPrefix = { fg = accent },
			TelescopePromptTitle = { fg = accent, reverse = true, bold = true },
			TelescopeResultsBorder = { fg = bg_dark, bg = bg_dark },
			TelescopeResultsTitle = { fg = bg_dark, bg = bg_dark },
		},
		-- highlights specific to dracula, like a different accent color
		["dracula"] = {
			-- ...
		},
		-- highlights specific to any catppuccin variant
		["catppuccin*"] = {
			-- ...
		},
	}
end

return {
	"bwpge/colorful.nvim",
	opts = {
		-- this option accepts a function and expects it to return a table like we built above.
		-- using a function allows the colors to be "refreshed" each time it is called.
		highlights = make_hl_table,
		-- creates a ColorScheme autocmd to apply these changes on each colorscheme change
		create_autocmd = true,
		-- since we (presumably) load the plugin after the first colorscheme change, we probably
		-- need to apply the changes manually the first time. if you have a different setup, you
		-- can disable this behavior with `false`.
		apply_on_setup = true,
	},
	-- not strictly required, but we can lazy load to defer some of the work required to set the
	-- highlights (e.g., copying colors, adjustments, conversions, etc.)
	event = "VeryLazy",
}
