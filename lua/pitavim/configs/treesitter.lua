require("nvim-treesitter.install").compilers = { "gcc" }
local parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser"
require("nvim-treesitter.configs").setup({
	parser_install_dir = parser_install_dir,
	sync_install = true,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})
vim.filetype.add({
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
