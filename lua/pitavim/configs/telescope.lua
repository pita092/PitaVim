require("telescope").setup({
  defaults = {
    previewer = false,
    layout_strategy = "vertical",
    layout_config = {
      width = 0.8,
      height = 0.8,
      prompt_position = "top",
    },
    prompt_prefix = " 🔭 ",
    entry_prefix = " ● ",
    selection_caret = "  ● ",
    path_display = { "truncate" },
    file_ignore_patterns = {
      "dist",
      "target",
      "node_modules",
      "pack/plugins",
    },
  },
  pickers = {
    find_files = {},
  },
  extensions = {
    ["ui-select"] = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg",
    },
  },
  cond = function()
    return vim.fn.executable("make") == 1
  end,
  winblend = 30,
})
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
