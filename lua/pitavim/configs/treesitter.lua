---@diagnostic disable: missing-fields
require("nvim-treesitter.install").compilers = { "gcc" }
local parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser"
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "vim", "vimdoc", "query", "c" },
	parser_install_dir = parser_install_dir,
	auto_install = true,

	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
})

vim.filetype.add({
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
