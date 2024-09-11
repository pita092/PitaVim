require("nvim-autopairs").setup({})

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local lsp = require("lsp-zero")
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
    completion = blankaborder,
    documentation = blankaborder,
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

  sources = {
    {
      name = "lazydev",
      group_index = 0,
    },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "spell",      keyword_length = 3, priority = 5 },
    { name = "dictionary", keyword_length = 3, priority = 5 },
    { name = "nvim_lua" },
    { name = "calc" },
  },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    expandable_indicator = true,
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, " ", { trimempty = true })
      kind.kind = string.format("%s  %s", kind_icons[vim_item.kind], strings[1])
      vim.api.nvim_set_hl(0, "CmpSel", { bg = "#fbf1c7", fg = "#282828" })
      -- This concatenates the icons with the name of the item kind

      -- NOTE: Don't remove the line below if you don't want the CMP to go haywire
      kind.menu = "" .. (strings[2] or "") .. ""

      return kind
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
    ghost_text = true,
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})
-- `/` cmdline setup.
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})
-- `:` cmdline setup.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})

vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#fbf1c7", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#b8bb26", bg = "NONE", bold = true })
