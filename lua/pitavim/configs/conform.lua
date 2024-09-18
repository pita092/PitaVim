require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua", "luaformatter" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		go = { "gofumpt", "goimports_reviser", "golines" },
	},
})
