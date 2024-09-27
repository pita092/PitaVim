---@diagnostic disable: missing-fields
require("nvim-treesitter.install").compilers = { "gcc" }
local parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser"
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "vim", "vimdoc", "query", "c" },
	parser_install_dir = parser_install_dir,
	auto_install = true,

	highlight = { enable = true },
	indent = { enable = true },
	require("nvim-treesitter.configs").setup({
		textobjects = {
			select = {
				enable = true,

				lookahead = true,

				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
				},

				selection_modes = {
					["@parameter.outer"] = "v",
					["@function.outer"] = "V",
					["@class.outer"] = "<c-v>",
				},
				include_surrounding_whitespace = true,
			},
		},
	}),
})

vim.filetype.add({
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
