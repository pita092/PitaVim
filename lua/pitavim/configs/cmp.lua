dofile(vim.g.base46_cache .. "cmp")
vim.api.nvim_set_hl(0, "CmpGhostText", { italic = true, fg = "#888888" })

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

local cmp = require("cmp")
local cmp = require("cmp")
local neogen = require("neogen")
local luasnip = require("luasnip")
local blankaborder = {
	border = { "", "", "", "", "", "", "", "" },
	winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:None",
	scrollbar = false,
	side_padding = 0,
}

local borderstyle = {
	border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
	winhighlight = "Normal:CmpNormal,CursorLine:CmpSel,Search:None",
	scrollbar = false,
	side_padding = 0,
}
-- local border2 =
-- 	{
-- 		border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
-- 		winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
-- 		scrollbar = false,
-- 		side_padding = 0,
-- 	},

require("luasnip.loaders.from_vscode").lazy_load()
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
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
	}),

	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "codeium" },
		{ name = "lazydev", group_index = 0 },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "spell" },
		{ name = "dictionary" },
		{ name = "calc" },
	},
	formatting = {
		fields = { "menu", "abbr", "kind" }, -- Changed the order here
		expandable_indicator = true,
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, " ", { trimempty = true })

			-- Set the menu first
			vim_item.menu = ({
				nvim_lsp = "[Lsp] ",
				buffer = "[Buff] ",
				path = "[Path] ",
				luasnip = "[Snips] ",
				lazydev = "[Lazy] ",
				Codeium = "[AI]",
				-- Add other sources as needed
			})[entry.source.name] or ""

			-- Combine menu and kind
			kind.kind = string.format("%s %s", vim_item.menu, strings[1] or "")

			-- NOTE: Don't remove the line below if you don't want the CMP to go haywire
			kind.menu = "" .. (strings[2] or "") .. ""
			return vim_item
		end,
	},

	performance = {
		debounce = 300,
		throttle = 60,
		fetching_timeout = 200,
		confirm_resolve_timeout = 80,
		async_budget = 1,
		max_view_entries = 50,
	},
	experimental = {
		ghost_text = {
			enabled = true,
			hl_group = "CmpGhostText",
		},
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			require("clangd_extensions.cmp_scores"),
			require("cmp-under-comparator").under,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
		priority_weight = 2,
	},
})
cmdline_formatting = {
	format = function(entry, vim_item)
		-- Customize the format for cmdline items
		vim_item.kind = "" -- Example: Set all items to have "CMD" as kind
		vim_item.menu = ({
			nvim_lsp = "[LSP]",
			buffer = "[Buff]",
			path = "[Path]",
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
