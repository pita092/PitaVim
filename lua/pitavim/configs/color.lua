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
    }
end


return {

			highlights = make_hl_table,
			create_autocmd = true,
			apply_on_setup = true,

}
