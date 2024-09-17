require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua", "luaformatter" },
    c = {},
    cpp = { "clang_format" },
  },
})
