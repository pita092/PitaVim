require("nvim-autopairs").setup({})

local settings = require("pitavim.settings")
local luasnip = require("luasnip")
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

local lspkind = require("lspkind")

local tailwindcss_colorizer_cmp = require("tailwindcss-colorizer-cmp")

--
local cmp_kinds = {
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
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = blankaborder,
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
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "treesitter" },
	}),
	-- formatting = {
	-- 	fields = { "menu", "abbr", "kind" },
	-- 	expandable_indicator = true,
	-- 	format = function(entry, vim_item)
	-- 		local kind = require("lspkind").cmp_format({ mode = "text", maxwidth = 50 })(entry, vim_item)
	-- 		local strings = vim.split(kind.kind, " ", { trimempty = true })
	-- 		vim.api.nvim_set_hl(0, "CmpSel", { bg = "#fbf1c7", fg = "#282828" })
	--
	-- 		-- This concatenates the icons with the name of the item kind
	-- 		-- NOTE: Don't remove the line below if you don't want the CMP to go haywire
	-- 		kind.menu = "" .. (strings[2] or "") .. ""
	--
	-- 		-- Define your icons
	-- 		local icons = {
	-- 			Text = "󰉿",
	-- 			Method = "󰆧",
	-- 			Function = "󰊕",
	-- 			Constructor = "",
	-- 			Field = "󰜢",
	-- 			Variable = "󰀫",
	-- 			Class = "󰠱",
	-- 			Interface = "",
	-- 			Module = "",
	-- 			Property = "󰜢",
	-- 			Unit = "󰑭",
	-- 			Value = "󰎠",
	-- 			Enum = "",
	-- 			Keyword = "󰌋",
	-- 			Snippet = "",
	-- 			Color = "󰏘",
	-- 			File = "󰈙",
	-- 			Reference = "󰈇",
	-- 			Folder = "󰉋",
	-- 			EnumMember = "",
	-- 			Constant = "󰏿",
	-- 			Struct = "󰙅",
	-- 			Event = "",
	-- 			Operator = "󰆕",
	-- 			TypeParameter = "",
	-- 		}
	--
	-- 		-- Set the icon and kind
	-- 		-- kind.kind = string.format('%s %s', icons[vim_item.kind] or '', vim_item.kind)
	-- 		vim_item.kind = (icons[vim_item.kind] or "") .. ""
	--
	-- 		-- Set the source
	-- 		vim_item.menu = ({
	-- 			nvim_lsp = "[LSP]",
	-- 			luasnip = "[Snippet]",
	-- 			buffer = "[Buffer]",
	-- 			path = "[Path]",
	-- 		})[entry.source.name]
	--
	-- 		vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#928374", italic = true })
	--
	-- 		return kind, vim_item
	-- 	end,
	-- },

	-- formatting = {
	--   fields = { "abbr", "kind" },
	--   expandable_indicator = true,
	--   format = function(entry, vim_item)
	--     local kind = require("lspkind").cmp_format({ mode = "text", maxwidth = 27 })(entry, vim_item)
	--     local strings = vim.split(kind.kind, " ", { trimempty = true })
	--     vim.api.nvim_set_hl(0, "CmpSel", { bg = "#fbf1c7", fg = "#282828" })
	--
	--     -- Define your icons
	--
	-- local icons = {
	--   Text = "󰉿",
	--   Method = "󰆧",
	--   Function = "󰊕",
	--   Constructor = "",
	--   Field = "󰜢",
	--   Variable = "󰀫",
	--   Class = "󰠱",
	--   Interface = "",
	--   Module = "",
	--   Property = "󰜢",
	--   Unit = "󰑭",
	--   Value = "󰎠",
	--   Enum = "",
	--   Keyword = "󰌋",
	--   Snippet = "",
	--   Color = "󰏘",
	--   File = "󰈙",
	--   Reference = "󰈇",
	--   Folder = "󰉋",
	--   EnumMember = "",
	--   Constant = "󰏿",
	--   Struct = "󰙅",
	--   Event = "",
	--   Operator = "󰆕",
	--   TypeParameter = "",
	-- }
	--
	--     -- Define keywords for each kind
	--     local keywords = {
	--       Text = "Text",
	--       Method = "Method",
	--       Function = "Function",
	--       Constructor = "Constructor",
	--       Field = "Field",
	--       Variable = "Variable",
	--       Class = "Class",
	--       Interface = "Interface",
	--       Module = "Module",
	--       Property = "Property",
	--       Unit = "Unit",
	--       Value = "Value",
	--       Enum = "Enum",
	--       Keyword = "Keyword",
	--       Snippet = "Snippet",
	--       Color = "Color",
	--       File = "File",
	--       Reference = "Reference",
	--       Folder = "Fold",
	--       EnumMember = "EnumMember",
	--       Constant = "Constant",
	--       Struct = "Struct",
	--       Event = "Event",
	--       Operator = "Operator",
	--       TypeParameter = "TypeParameter",
	--     }
	--
	--     -- Set the icon, keyword, and kind
	--     local icon = icons[vim_item.kind] or ""
	--     local keyword = keywords[vim_item.kind] or ""
	--     vim_item.kind = string.format("%s %s", icon, keyword)
	--
	--     -- Set the source
	--     vim_item.menu = ({
	--       nvim_lsp = "[LSP]",
	--       luasnip = "[Snippet]",
	--       buffer = "[Buffer]",
	--       path = "[Path]",
	--     })[entry.source.name]
	--
	--     vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#fbf1c7", italic = true })
	--
	--     return vim_item
	--   end,
	-- },

	formatting = {
		fields = settings.cmp_style == "nvchad" and { "kind", "abbr", "menu" } or nil,
		format = function(entry, item)
			-- vscode like icons for cmp autocompletion
			local fmt = lspkind.cmp_format({
				-- with_text = false, -- hide kind beside the icon
				mode = "symbol_text",
				maxwidth = 50,
				ellipsis_char = "...",
				before = tailwindcss_colorizer_cmp.formatter, -- prepend tailwindcss-colorizer
			})(entry, item)

			-- customize lspkind format
			local strings = vim.split(fmt.kind, "%s", { trimempty = true })

			-- strings[1] -> default icon
			-- strings[2] -> kind

			-- set different icon styles
			if settings.cmp_icons_style == "vscode" then
				fmt.kind = " " .. (cmp_kinds[strings[2]] or "") -- concatenate icon based on kind
			else
				fmt.kind = " " .. (strings[1] or "") -- just use the default icon
			end

			-- append customized kind text
			if settings.cmp_style == "nvchad" then
				fmt.kind = fmt.kind .. " " -- just an extra space at the end
				fmt.menu = strings[2] ~= nil and ("  " .. (strings[2] or "")) or ""
			else
				-- default and others
				fmt.menu = strings[2] ~= nil and (strings[2] or "") or ""
			end

			return fmt
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
