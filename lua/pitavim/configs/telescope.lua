require('telescope').setup {
  defaults = {
    prompt_prefix = ' 🔭 ',
    entry_prefix = " ● ",
    selection_caret = '  ● ',
    path_display = { 'truncate' },
    file_ignore_patterns = {
      'dist',
      'target',
      'node_modules',
      'pack/plugins',
    },
  },
  pickers = {
    find_files = {
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
    media_files = {
      filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
      find_cmd = 'rg',
    },
  },
  cond = function()
    return vim.fn.executable 'make' == 1
  end,
  winblend = 30,
}
require('telescope').load_extension 'ui-select'
require('telescope').load_extension 'fzf'

---
---
---
---
---
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"

local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"
local make_entry = require "telescope.make_entry"

ocal
function wrapper()
  local term_bufs = vim.g.nvchad_terms or {}
  local buffers = {}

  for buf, _ in pairs(term_bufs) do
    buf = tonumber(buf)
    local element = { bufnr = buf, flag = "", info = vim.fn.getbufinfo(buf)[1] }
    table.insert(buffers, element)
  end

  local bufnrs = vim.tbl_keys(term_bufs)

  if #bufnrs == 0 then
    print "no terminal buffers are opened/hidden!"
    return
  end

  local opts = { bufnr_width = math.max(unpack(bufnrs)) }

  local picker = pickers.new {
    prompt_title = " Pick Term",
    previewer = conf.grep_previewer(opts),
    finder = finders.new_table {
      results = buffers,
      entry_maker = make_entry.gen_from_buffer(opts),
    },
    sorter = conf.generic_sorter(),

    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        -- open term only if its window isnt opened
        if vim.fn.bufwinid(entry.bufnr) == -1 then
          local termopts = vim.g.nvchad_terms[tostring(entry.bufnr)]
          require("nvchad.term").display(termopts)
        end
      end)
      return true
    end,
  }

  picker:find()
end

local function reload_theme(name)
  require("nvconfig").ui.theme = name
  require("base46").load_all_highlights()
  vim.api.nvim_exec_autocmds("User", { pattern = "NvChadThemeReload" })
end

local function switcher()
  local bufnr = vim.api.nvim_get_current_buf()

  -- show current buffer content in previewer
  local previewer = previewers.new_buffer_previewer {
    define_preview = function(self, entry)
      -- add content
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

      -- add syntax highlighting in previewer
      local ft = (vim.filetype.match { buf = bufnr } or "diff"):match "%w+"
      require("telescope.previewers.utils").highlighter(self.state.bufnr, ft)
    end,
  }

  -- our picker function: colors
  local picker = pickers.new {
    prompt_title = "󱥚 Set NvChad Theme",
    previewer = previewer,
    finder = finders.new_table {
      results = require("nvchad.utils").list_themes(),
    },
    sorter = conf.generic_sorter(),

    attach_mappings = function(prompt_bufnr)
      -- reload theme while typing
      vim.schedule(function()
        vim.api.nvim_create_autocmd("TextChangedI", {
          buffer = prompt_bufnr,
          callback = function()
            if action_state.get_selected_entry() then
              reload_theme(action_state.get_selected_entry()[1])
            end
          end,
        })
      end)
      -- reload theme on cycling
      actions.move_selection_previous:replace(function()
        action_set.shift_selection(prompt_bufnr, -1)
        reload_theme(action_state.get_selected_entry()[1])
      end)
      actions.move_selection_next:replace(function()
        action_set.shift_selection(prompt_bufnr, 1)
        reload_theme(action_state.get_selected_entry()[1])
      end)

      ------------ save theme to chadrc on enter ----------------
      actions.select_default:replace(function()
        if action_state.get_selected_entry() then
          local chadrc = dofile(vim.fn.stdpath "config" .. "/lua/chadrc.lua")
          local old_theme = chadrc.ui and chadrc.ui.theme or chadrc.base46.theme
          old_theme = '"' .. old_theme .. '"'

          local theme = '"' .. action_state.get_selected_entry()[1] .. '"'

          require("nvchad.utils").replace_word(old_theme, theme)
          actions.close(prompt_bufnr)
        end
      end)
      return true
    end,
  }

  picker:find()
end

return require("telescope").register_extension {
  exports = { terms = wrapper },
}
