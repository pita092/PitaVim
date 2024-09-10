-- local options = {
--   ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc" },
--
--   highlight = {
--     enable = true,
--     use_languagetree = true,
--   },
--
--   indent = { enable = true },
--   vim.filetype.add({
--     pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
--   })
-- }

require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
  sync_install = true,
  auto_install = true,
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
    },
  },
  vim.filetype.add({
    pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
  }),
})
