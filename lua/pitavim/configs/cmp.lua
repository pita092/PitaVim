require("nvim-autopairs").setup({})

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.setup()
local kind_icons = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰜢",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "󰈇",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "󰙅",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "",
}
local blankaborder = {
	border = { "", "", "", "", "", "", "", "" },
	winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
	scrollbar = false,
	side_padding = 0,
}

local borderstyle = {
	border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
	winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
	scrollbar = false,
	side_padding = 0,
}
local border2 =
	{
		border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
		winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
		scrollbar = false,
		side_padding = 0,
	}, require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("c", { "cdoc" })

cmp.setup({

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = borderstyle,
		documentation = borderstyle,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp_action.luasnip_supertab(),
		["<C-Tab>"] = cmp_action.luasnip_shift_supertab(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "treesitter" },
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		expandable_indicator = true,
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (kind_icons[strings[1]] or "") .. " " .. strings[1]
			kind.menu = (strings[2] or "")
			return kind
		end,
	},

	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			require("cmp-under-comparator").under,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})

vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#fbf1c7", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#b8bb26", bg = "NONE", bold = true })
vim.lsp.set_log_level("debug")
