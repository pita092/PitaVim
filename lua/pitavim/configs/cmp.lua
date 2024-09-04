require("nvim-autopairs").setup({})

local luasnip = require("luasnip")
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

local borderstyle = {
	border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
	winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
}
local border2 =
	{
		border = { "T", "=", "T", "}", "+", "=", "+", "{"},
		winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
	}, require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("c", { "cdoc" })

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = border2,
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
		["<C-l>"] = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "treesitter" },
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		expandable_indicator = true,
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, " ", { trimempty = true })
			vim.api.nvim_set_hl(0, "CmpSel", { bg = "#fbf1c7", fg = "#282828" })

			-- This concatenates the icons with the name of the item kind
			-- NOTE: Don't remove the line below if you don't want the CMP to go haywire
			kind.menu = "" .. (strings[2] or "") .. ""

			-- Define your icons
			local icons = {
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

			-- Set the icon and kind
			-- kind.kind = string.format('%s %s', icons[vim_item.kind] or '', vim_item.kind)
			vim_item.kind = (icons[vim_item.kind] or "") .. ""

			-- Set the source
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]

			vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#928374", italic = true })

			return kind, vim_item
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
cmp.setup.cmdline("@", { enabled = false })
cmp.setup.cmdline(">", { enabled = false })
cmp.setup.cmdline("-", { enabled = false })
cmp.setup.cmdline("=", { enabled = false })
