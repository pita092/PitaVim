require('nvim-autopairs').setup {}

local luasnip = require 'luasnip'
local cmp = require 'cmp'
local cmp_action = require('lsp-zero').cmp_action()
local lspkind = require('lspkind')
local kind_icons = {
  Text = '󰉿',
  Method = '󰆧',
  Function = '󰊕',
  Constructor = '',
  Field = '󰜢',
  Variable = '󰀫',
  Class = '󰠱',
  Interface = '',
  Module = '',
  Property = '󰜢',
  Unit = '󰑭',
  Value = '󰎠',
  Enum = '',
  Keyword = '󰌋',
  Snippet = '',
  Color = '󰏘',
  File = '󰈙',
  Reference = '󰈇',
  Folder = '󰉋',
  EnumMember = '',
  Constant = '󰏿',
  Struct = '󰙅',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '',
}
local borderstyle = {
  border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
  winhighlight = 'Normal:CmpPmenu,CursorLine:CmpSel,Search:None',
}

require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip').filetype_extend('c', { 'cdoc' })

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = borderstyle,
    documentation = borderstyle,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<C-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<C-l>'] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'treesitter' },
  },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    expandable_indicator = true,
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol', -- Show only symbol icons
        maxwidth = 50, -- Prevent the popup from becoming too wide
        before = function(entry, vim_item)
          -- Customize the menu to show kind and source wrapped in brackets
          vim_item.menu = string.format("[%s] [%s]", vim_item.kind, entry.source.name)
          return vim_item
        end,
      }),

    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        require "cmp-under-comparator".under,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  } }
