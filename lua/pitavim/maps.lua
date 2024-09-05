local map = vim.keymap.set

vim.keymap.set("n", "<leader>pv", ":Neotree current<CR>", { desc = "File Tree" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "General Save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "General Copy whole file" })

--map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Toggle nvcheatsheet" })

vim.keymap.set("n", "<C-h>", vim.lsp.buf.format, {})

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP Diagnostic loclist" })

-- neotree/oil
map("n", "<leader>e", ":Neotree reveal right<CR>", { desc = "neotree reavel" })
map("n", "<C-D", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<C-x>", ":lua require('oil').close()<CR>", { desc = "Close oil" })

-- telescope
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

vim.keymap.set("n", "<leader>H", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>K", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>o", builtin.live_grep, { desc = "[O] Live grep" })
vim.keymap.set("n", "<leader>s", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>r", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>p", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })

vim.keymap.set("n", "<leader><leader>", function()
  builtin.buffers(require("telescope.themes").get_dropdown({
    winblend = 0,
    previewer = true,
  }))
end, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find(themes.get_dropdown({
    winblend = 0,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>sn", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
map("n", "<leader>v", function()
  require("nvterm.terminal").toggle("float")
end, { desc = "terminal new vertical window" })

vim.api.nvim_set_keymap("n", "<C-q>", ":bdelete!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-q>", "<C-\\><C-n>:bdelete!<CR>", { noremap = true, silent = true })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" })

--tabline

vim.keymap.set("n", "<C-e>", ":tabnext<CR>", { noremap = true, silent = true, desc = "next tab" })
vim.keymap.set("n", "<C-w>", ":tabclose<CR>", { noremap = true, silent = true, desc = "next tab" })
vim.keymap.set("n", "<C-q>", ":tabprevious<CR>", { noremap = true, silent = true, desc = "previous tab" })

--custom menu

vim.keymap.set("n", "<leader>d", function()
  local dashboard_opened = require("pitavim.scripts.menu").toggle_dashboard()
  if dashboard_opened then
    print("Dasboard opned")
  else
    print("Dashboard closed")
  end
end, { desc = "Toggle dashboard" })
