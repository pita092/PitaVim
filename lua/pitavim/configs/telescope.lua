local lspkind = require("lspkind")

require("telescope").setup({
  pickers = {
    find_files = {
      prompt_title = "/*Find Files*/",
      prompt_prefix = " ",
    },
    live_grep = {
      prompt_title = "/*Search Text*/",
      prompt_prefix = "🕵️‍♂️ ",
    },
    current_buffer_fuzzy_find = {
      prompt_title = "/*Fuzzy Find Current Buffer*/",
      prompt_prefix = " ",
    },
    git_files = {
      prompt_title = "/*Git File*/",
      prompt_prefix = " ",
    },
    builtin = {
      prompt_title = "/*Global Telescope Menu*/",
      prompt_prefix = "  ",
    },
    help_tags = {
      prompt_title = "/*Global Telescope Menu*/",
      prompt_prefix = " ",
    },
    git_commits = {
      prompt_title = "/*Git Commits*/",
      prompt_prefix = " ",
    },
    keymaps = {
      prompt_title = "/*Keymaps*/",
      prompt_prefix = " ",
    },
  },
  defaults = {
    require("telescope.themes").get_dropdown(),
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    previewer = false,
    prompt_prefix = "  ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    borderchars = { "", "", "", "", "", "", "", "" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
  extensions = {
    cmdline = {
      format_item = function(entry, item)
        local icon = lspkind.presets.default[item.kind]
        return string.format("%s %s", icon, item.label)
      end,
      picker = {
        prompt_title = "/*Cmdline*/",
        prompt_prefix = "  ",

        layout_config = {
          width = 70,
          height = 25,
        },
      },
      mappings = {
        complete = "<Tab>",
        run_selection = "<C-CR>",
        run_input = "<CR>",
      },
    },
    ["ui-select"] = {
      require("telescope.themes").get_cursor({
        width = 0.8,
        previewer = false,
      }),
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
})
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local conf = require("telescope.config").values

-- Custom actions
local custom_actions = {}

function custom_actions.select_language(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  print("You selected: " .. selection.value)
  -- Here you can add more functionality, like opening a file or running a command
  -- based on the selected language
  if selection.value == "Python" then
    vim.cmd("edit ~/.config/nvim/ftplugin/python.lua")
  elseif selection.value == "JavaScript" then
    vim.cmd("edit ~/.config/nvim/ftplugin/javascript.lua")
  elseif selection.value == "Rust" then
    vim.cmd("!cargo new my_rust_project")
  end
end

-- Transform the custom actions
local transform_mod = require("telescope.actions.mt").transform_mod
custom_actions = transform_mod(custom_actions)

-- Create the custom picker
local function language_picker(opts)
  opts = opts or {}
  pickers
      .new(opts, {
        prompt_title = "Select a Programming Language",
        finder = finders.new_table({
          results = { "Python", "JavaScript", "Rust", "Go", "Java", "C++", "Ruby" },
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry,
              ordinal = entry,
            }
          end,
        }),
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr, map)
          map("i", "<CR>", custom_actions.select_language)
          map("n", "<CR>", custom_actions.select_language)
          return true
        end,
      })
      :find()
end

-- Set up a keymap to open the picker
vim.api.nvim_set_keymap("n", "<leader>lp", "<cmd>lua language_picker()<CR>", { noremap = true, silent = true })

-- defaults = {
--   border = false,
--   previewer = false,
--   layout_strategy = "vertical",
--   layout_config = {
--     width = 0.8,
--     height = 0.8,
--     prompt_position = "top",
--   },
--   prompt_prefix = " 🔭 ",
--   entry_prefix = " ● ",
--   selection_caret = "  ● ",
--   path_display = { "truncate" },
--   file_ignore_patterns = {
--     "dist",
--     "target",
--     "node_modules",
--     "pack/plugins",
--   },
-- },
-- pickers = {
--   find_files = {},
-- },
-- extensions = {
--   ["ui-select"] = {
--     fzf = {
--       fuzzy = true,
--       override_generic_sorter = true,
--       override_file_sorter = true,
--       case_mode = "smart_case",
--     },
--   },
--   media_files = {
--     filetypes = { "png", "webp", "jpg", "jpeg" },
--     find_cmd = "rg",
--   },
-- },
-- cond = function()
--   return vim.fn.executable("make") == 1
-- end,
-- winblend = 30,
