require("nvim-autopairs").setup({})

local luasnip = require("luasnip")
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

local blankaborder = {
	border = { "", "", "", "", "", "", "", "" },
	winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
}

local borderstyle = {
	border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
	winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
}
local border2 =
	{
		border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
		winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
	}, require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("c", { "cdoc" })

cmp.setup({

	formatting = {
		fields = { "abbr", "kind" },
		format = function(entry, vim_item)
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
			local icon = icons[vim_item.kind] or ""
			vim_item.kind = string.format("%s %s", icon, vim_item.kind)

			-- Set the abbreviation
			local abbr = vim_item.abbr
			local max_abbr_width = 30 -- Adjust this as needed
			if #abbr > max_abbr_width then
				vim_item.abbr = vim.fn.strcharpart(abbr, 0, max_abbr_width - 3) .. "..."
			end

			-- Add a single space after the abbreviation
			vim_item.abbr = vim_item.abbr .. " "

			-- Set the source (menu)
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name] or ""

			-- Trim spaces from the end of the menu entry
			vim_item.menu = vim_item.menu:gsub("%s+", " ")

			return vim_item
		end,
	},

	window = {
		completion = {
			border = "single",
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
			col_offset = 0, -- Adjust this to control the horizontal alignment
			side_padding = 0, -- Remove side padding
		},
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
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
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "treesitter" },
	}),
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
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#fabd2f", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#fbf1c7", bg = "#282828" })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#282828", bg = "#fbf1c7" })
