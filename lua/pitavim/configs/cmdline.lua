local cmdline_formatting = {
	format = function(entry, vim_item)
		-- Customize the format for cmdline items
		vim_item.kind = "" -- Example: Set all items to have "CMD" as kind
		vim_item.menu = ({
			buffer = "[Buff]",
			path = "[Path]",
			cmdline = "[Cmd]",
		})[entry.source.name]
		return vim_item
	end,
}
-- `/` cmdline setup.
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	formatting = cmdline_formatting,
	sources = {
		{ name = "buffer" },
	},
})
-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	formatting = cmdline_formatting,
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "Dashboard" },
			},
		},
	}),
})

vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#fbf1c7", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#b8bb26", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#3c3836" })
