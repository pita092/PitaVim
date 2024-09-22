-- vim.cmd("highlight clear TabLineFill")
-- vim.cmd("highlight clear NeoTreeNormal")
-- vim.cmd("highlight clear NeoTreeNormalNC")
-- vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#fabd2f", bg = "NONE", bold = true })
-- vim.api.nvim_set_hl(0, "TabLineSelIconBg", { bg = "#504945" })
-- vim.api.nvim_set_hl(0, "TabLineIconBg", { bg = "#3c3836" })
-- vim.api.nvim_set_hl(0, "WarningMsg", { fg = "#fabd2f", bg = "#3c3836" })
-- vim.api.nvim_set_hl(0, "ErrorMsg", { fg = "#fb4934", bg = "#3c3836" })
-- vim.api.nvim_set_hl(0, "InfoMsg", { fg = "#83a598", bg = "#3c3836" })
-- vim.api.nvim_set_hl(0, "HintMsg", { fg = "#8ec07c", bg = "#3c3836" })

-- local M = {}
-- local function get_file_icon(filename)
--   local file_icon = {
--     ["lua"] = "󰢱 ",
--     ["py"] = " ",
--     ["js"] = " ",
--     ["ts"] = " ",
--     ["json"] = " ",
--     ["cpp"] = " ",
--     ["yml"] = "",
--     ["yaml"] = "",
--     ["toml"] = " ",
--     ["md"] = " ",
--     ["txt"] = " ",
--     ["vim"] = " ",
--     ["sh"] = " ",
--     ["bash"] = " ",
--     ["zsh"] = " ",
--     ["fish"] = "  ",
--     ["conf"] = " ",
--     ["ini"] = "",
--     ["gitignore"] = " ",
--     ["gitconfig"] = " ",
--   }
--   local extension = filename:match("^.+%.(.+)$")
--   return file_icon[extension] or ""
-- end
-- --
-- -- function M.MyTabLine()
-- --   local s = '%#TabLineFill#%{v:lua.require("pitavim.scripts.tabline").ClearHighlight()}'
-- --   for i = 1, vim.fn.tabpagenr("$") do
-- --     -- Add a separator before each tab (except the first one)
-- --     if i > 1 then
-- --       s = s .. "|%#TabLineFill#|"
-- --     end
-- --
-- --     if i == vim.fn.tabpagenr() then
-- --       s = s .. "%#TabLineSel#"
-- --     else
-- --       s = s .. "%#TabLine#"
-- --     end
-- --
-- --     s = s .. "%" .. i .. "T"
-- --     s = s .. ' %{v:lua.require("pitavim.scripts.tabline").MyTabLabel(' .. i .. ")} "
-- --   end
-- --   s = s .. "%#TabLineFill#%T"
-- --   return s
-- -- end
-- --
-- -- function M.MyTabLabel(n)
-- --   local buflist = vim.fn.tabpagebuflist(n)
-- --   local winnr = vim.fn.tabpagewinnr(n)
-- --   local bufnr = buflist[winnr]
-- --   local filename = vim.fn.bufname(bufnr)
-- --   local icon = get_file_icon(filename)
-- --   local short_name = vim.fn.fnamemodify(filename, ":t")
-- --   short_name = short_name ~= "" and short_name or "[No Name]"
-- --   return icon .. " " .. short_name
-- -- end
-- --
-- -- function M.ClearHighlight()
-- --   vim.cmd("highlight clear TabLineFill")
-- --   vim.cmd("highlight clear NeoTreeNormal")
-- --   vim.cmd("highlight clear NeoTreeNormalNC")
-- --   vim.cmd('lua vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#fabd2f", bg = "NONE" })')
-- --   return "" -- This function needs to return a string for the tabline
-- -- end
-- --
-- -- function M.setup()
-- --   vim.o.tabline = [[%!v:lua.require'pitavim.scripts.tabline'.MyTabLine()]]
-- -- end
-- --
--
-- local function get_lsp_diagnostics(bufnr)
--   local diagnostics = vim.diagnostic.get(bufnr)
--   local count = { errors = 0, warnings = 0, info = 0, hints = 0 }
--   for _, diagnostic in ipairs(diagnostics) do
--     if diagnostic.severity == vim.diagnostic.severity.ERROR then
--       count.errors = count.errors + 1
--     elseif diagnostic.severity == vim.diagnostic.severity.WARN then
--       count.warnings = count.warnings + 1
--     elseif diagnostic.severity == vim.diagnostic.severity.INFO then
--       count.info = count.info + 1
--     elseif diagnostic.severity == vim.diagnostic.severity.HINT then
--       count.hints = count.hints + 1
--     end
--   end
--   return count
-- end
--
-- function M.MyTabLabel(n)
--   local buflist = vim.fn.tabpagebuflist(n)
--   local winnr = vim.fn.tabpagewinnr(n)
--   local bufnr = buflist[winnr]
--   local filename = vim.fn.bufname(bufnr)
--   local icon = get_file_icon(filename)
--   local short_name = vim.fn.fnamemodify(filename, ":t")
--   short_name = short_name ~= "" and short_name or "[No Name]"
--
--   -- Get LSP diagnostics for the buffer
--   local diagnostics = get_lsp_diagnostics(bufnr)
--
--   return {
--     icon = icon,
--     text = short_name,
--     warnings = diagnostics.warnings,
--     errors = diagnostics.errors,
--   }
-- end
--
-- function M.MyTabLine()
--   local s = '%#TabLineFill#%{v:lua.require("pitavim.scripts.tabline").ClearHighlight()}'
--   for i = 1, vim.fn.tabpagenr("$") do
--     if i > 1 then
--       s = s .. "%#TabLineFill#"
--     end
--
--     local is_selected = i == vim.fn.tabpagenr()
--     local tab_hl = is_selected and "%#TabLineSel#" or "%#TabLine#"
--     local icon_hl = is_selected and "%#TabLineSelIcon#" or "%#TabLineIcon#"
--
--     s = s .. "%" .. i .. "T"
--
--     local label = M.MyTabLabel(i)
--     s = s .. tab_hl .. " " .. icon_hl .. label.icon .. tab_hl .. " " .. label.text
--
--     -- Add LSP warning and error icons without numbers
--     if label.warnings > 0 then
--       s = s .. " %#WarningMsg#" .. " " -- You can replace " " with your preferred warning icon
--     end
--     if label.errors > 0 then
--       s = s .. " %#ErrorMsg#" .. " " -- You can replace " " with your preferred error icon
--     end
--
--     s = s .. " "
--   end
--   s = s .. "%#TabLineFill#%T"
--   return s
-- end
--
-- function M.ClearHighlight()
--   vim.cmd("highlight clear TabLineFill")
--   vim.cmd("highlight clear NeoTreeNormal")
--   vim.cmd("highlight clear NeoTreeNormalNC")
--   vim.cmd('lua vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#fabd2f", bg = "#3c3836", bold = true })')
--   vim.cmd('lua vim.api.nvim_set_hl(0, "TabLine", { fg = "#fbf1c7", bg = "NONE" })')
--   vim.cmd('lua vim.api.nvim_set_hl(0, "TabLineIcon", { fg = "#61afef", bg = "NONE" })')
--   vim.cmd('lua vim.api.nvim_set_hl(0, "TabLineSelIcon", { fg = "#61afef", bg = "#3c3836", bold = true })')
--   vim.cmd('lua vim.api.nvim_set_hl(0, "WarningMsg", { fg = "#fabd2f", bg = "NONE" })')
--   vim.cmd('lua vim.api.nvim_set_hl(0, "ErrorMsg", { fg = "#Fb4934", bg = "NONE" })')
--   return ""
-- end
--
-- function M.setup()
--   vim.o.tabline = [[%!v:lua.require'pitavim.scripts.tabline'.MyTabLine()]]
-- end
--
-- return M

---
---NEW
---CONFIG
---WITH
---WEBDEVICONS
---
-- local M = {}
-- local web_devicons = require("nvim-web-devicons")
--
-- local function get_file_icon(filename)
--   local extension = filename:match("^.+%.(.+)$")
--   local icon, icon_color = web_devicons.get_icon(filename, extension)
--   return icon or "", icon_color
-- end
--
-- local function get_lsp_diagnostics(bufnr)
--   local diagnostics = vim.diagnostic.get(bufnr)
--   local count = { errors = 0, warnings = 0, info = 0, hints = 0 }
--   for _, diagnostic in ipairs(diagnostics) do
--     if diagnostic.severity == vim.diagnostic.severity.ERROR then
--       count.errors = count.errors + 1
--     elseif diagnostic.severity == vim.diagnostic.severity.WARN then
--       count.warnings = count.warnings + 1
--     elseif diagnostic.severity == vim.diagnostic.severity.INFO then
--       count.info = count.info + 1
--     elseif diagnostic.severity == vim.diagnostic.severity.HINT then
--       count.hints = count.hints + 1
--     end
--   end
--   return count
-- end
--
-- function M.MyTabLabel(n)
--   local buflist = vim.fn.tabpagebuflist(n)
--   local winnr = vim.fn.tabpagewinnr(n)
--   local bufnr = buflist[winnr]
--   local filename = vim.fn.bufname(bufnr)
--   local icon, icon_color = get_file_icon(filename)
--   local short_name = vim.fn.fnamemodify(filename, ":t")
--   short_name = short_name ~= "" and short_name or "[No Name]"
--
--   -- Get LSP diagnostics for the buffer
--   local diagnostics = get_lsp_diagnostics(bufnr)
--
--   return {
--     icon = icon,
--     icon_color = icon_color,
--     text = short_name,
--     warnings = diagnostics.warnings,
--     errors = diagnostics.errors,
--   }
-- end
--
-- function M.MyTabLine()
--   local s = '%#TabLineFill#%{v:lua.require("pitavim.scripts.tabline").ClearHighlight()}'
--   for i = 1, vim.fn.tabpagenr("$") do
--     if i > 1 then
--       s = s .. "%#TabLineFill#"
--     end
--
--     local is_selected = i == vim.fn.tabpagenr()
--     local tab_hl = is_selected and " %#TabLineSel#" or " %#TabLine#"
--
--     s = s .. "%" .. i .. "T"
--
--     local label = M.MyTabLabel(i)
--     local icon_hl = string.format("%%#%s#", label.icon_color or (is_selected and "TabLineSelIcon" or "TabLineIcon"))
--     s = s .. tab_hl .. " " .. icon_hl .. label.icon .. tab_hl .. " " .. label.text
--
--     -- Add LSP warning and error icons without numbers
--     if label.warnings > 0 then
--       s = s .. " %#WarningMsg#" .. " "
--     end
--     if label.errors > 0 then
--       s = s .. " %#ErrorMsg#" .. " "
--     end
--
--     s = s .. " "
--   end
--   s = s .. "%#TabLineFill#%T"
--   return s
-- end
--
-- function M.ClearHighlight()
--   vim.cmd("highlight clear TabLineFill")
--   vim.cmd("highlight clear NeoTreeNormal")
--   vim.cmd("highlight clear NeoTreeNormalNC")
--   vim.cmd('lua vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#fabd2f", bg = "#3c3836", bold = true })')
--   vim.cmd('lua vim.api.nvim_set_hl(0, "TabLine", { fg = "#fbf1c7", bg = "NONE" })')
--   vim.cmd('lua vim.api.nvim_set_hl(0, "WarningMsg", { fg = "#fabd2f", bg = "NONE" })')
--   vim.cmd('lua vim.api.nvim_set_hl(0, "ErrorMsg", { fg = "#Fb4934", bg = "NONE" })')
--   return ""
-- end
--
-- function M.setup()
--   vim.o.tabline = [[%!v:lua.require'pitavim.scripts.tabline'.MyTabLine()]]
-- end
--
-- return MyTabLine
--
--


local M = {}
local web_devicons = require("nvim-web-devicons")

-- Table to store buffers for each tab
M.tab_buffers = {}

-- Function to get or create a buffer list for a tab
local function get_tab_buffers(tabnr)
  if not M.tab_buffers[tabnr] then
    M.tab_buffers[tabnr] = {}
  end
  return M.tab_buffers[tabnr]
end

-- Function to add a buffer to a tab's buffer list
local function add_buffer_to_tab(tabnr, bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then return end
  local buffers = get_tab_buffers(tabnr)
  if not vim.tbl_contains(buffers, bufnr) then
    table.insert(buffers, bufnr)
  end
end

-- Function to remove a buffer from a tab's buffer list
local function remove_buffer_from_tab(tabnr, bufnr)
  local buffers = get_tab_buffers(tabnr)
  for i = #buffers, 1, -1 do
    if buffers[i] == bufnr or not vim.api.nvim_buf_is_valid(buffers[i]) then
      table.remove(buffers, i)
    end
  end
end

local function get_file_icon(filename)
  local extension = filename:match("^.+%.(.+)$")
  local icon, icon_color = web_devicons.get_icon(filename, extension)
  return icon or "", icon_color or "Normal"
end

local function get_lsp_diagnostics(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return { errors = 0, warnings = 0, info = 0, hints = 0 }
  end
  local diagnostics = vim.diagnostic.get(bufnr)
  local count = { errors = 0, warnings = 0, info = 0, hints = 0 }
  for _, diagnostic in ipairs(diagnostics) do
    if diagnostic.severity == vim.diagnostic.severity.ERROR then
      count.errors = count.errors + 1
    elseif diagnostic.severity == vim.diagnostic.severity.WARN then
      count.warnings = count.warnings + 1
    elseif diagnostic.severity == vim.diagnostic.severity.INFO then
      count.info = count.info + 1
    elseif diagnostic.severity == vim.diagnostic.severity.HINT then
      count.hints = count.hints + 1
    end
  end
  return count
end

local function is_neo_tree_buffer(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then return false end
  local ok, filetype = pcall(vim.api.nvim_buf_get_option, bufnr, "filetype")
  if not ok then return false end
  return filetype == "neo-tree"
end

function M.MyTabLabel(n)
  local buflist = get_tab_buffers(n)
  local winnr = vim.fn.tabpagewinnr(n)
  local bufnr = buflist[winnr] or (buflist[1] or vim.fn.tabpagebuflist(n)[1])

  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
    return nil
  end

  -- If it's a Neo-tree buffer, find the next non-Neo-tree buffer in the tab
  if is_neo_tree_buffer(bufnr) then
    for _, buf in ipairs(buflist) do
      if vim.api.nvim_buf_is_valid(buf) and not is_neo_tree_buffer(buf) then
        bufnr = buf
        break
      end
    end
  end

  -- If we still have a Neo-tree buffer, return nil
  if is_neo_tree_buffer(bufnr) then
    return nil
  end

  local filename = vim.fn.bufname(bufnr)
  local icon, icon_color = get_file_icon(filename)
  local short_name = vim.fn.fnamemodify(filename, ":t")
  short_name = short_name ~= "" and short_name or ""

  local diagnostics = get_lsp_diagnostics(bufnr)

  return {
    icon = icon,
    icon_color = icon_color,
    text = short_name,
    warnings = diagnostics.warnings > 0,
    errors = diagnostics.errors > 0,
    info = diagnostics.info > 0,
    hints = diagnostics.hints > 0,
  }
end

function M.MyTabLine()
  if vim.bo.filetype == "alpha" then
    return ""
  end

  local s = '%#TabLineFill#%{v:lua.require("pitavim.scripts.tabline").ClearHighlight()}'
  for i = 1, vim.fn.tabpagenr("$") do
    local label = M.MyTabLabel(i)
    if not label then
      goto continue
    end

    local is_selected = i == vim.fn.tabpagenr()
    local tab_hl = is_selected and "%#TabLineSel#" or "%#TabLine#"
    local icon_bg = is_selected and "%#TabLineSelIconBg#" or "%#TabLineIconBg#"
    local border_hl = is_selected and "%#TabLineSelBorder#" or "%#TabLineBorder#"

    s = s .. "%" .. i .. "T"

    local icon_color = label.icon_color and ("%#" .. label.icon_color .. "#") or tab_hl

    -- Left border
    s = s .. border_hl .. "["

    -- Tab content
    s = s .. icon_bg .. icon_color .. label.icon .. " " .. tab_hl .. label.text

    -- Add LSP diagnostic icons without numbers
    if label.errors then
      s = s .. " %#ErrorMsg#" .. ""
    end
    if label.warnings then
      s = s .. " %#WarningMsg#" .. ""
    end
    if label.info then
      s = s .. " %#InfoMsg#" .. ""
    end
    if label.hints then
      s = s .. " %#HintMsg#" .. ""
    end

    -- Right border
    s = s .. border_hl .. "]"

    s = s .. "%#TabLineFill# " -- Space between tabs

    ::continue::
  end
  s = s .. "%#TabLineFill#%T"
  return s
end

function M.ClearHighlight()
  -- Your existing ClearHighlight function ...
end

function M.setup()
  vim.o.tabline = [[%!v:lua.require'pitavim.scripts.tabline'.MyTabLine()]]

  -- Initialize buffer lists for existing tabs
  for i = 1, vim.fn.tabpagenr('$') do
    local buffers = vim.fn.tabpagebuflist(i)
    M.tab_buffers[i] = vim.tbl_filter(function(buf)
      return vim.api.nvim_buf_is_valid(buf)
    end, buffers)
  end

  -- Autocommand to update buffer lists when switching tabs or opening/closing buffers
  vim.api.nvim_create_autocmd({"BufEnter", "TabEnter", "BufAdd", "BufDelete"}, {
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      local current_buf = vim.api.nvim_get_current_buf()
      if vim.api.nvim_buf_is_valid(current_buf) then
        add_buffer_to_tab(current_tab, current_buf)
      end
    end,
  })

  -- Autocommand to remove buffer from all tabs when it's deleted
  vim.api.nvim_create_autocmd("BufDelete", {
    callback = function(args)
      for tabnr, _ in pairs(M.tab_buffers) do
        remove_buffer_from_tab(tabnr, args.buf)
      end
    end,
  })

  -- Autocommand to create a new buffer list when a new tab is created
  vim.api.nvim_create_autocmd("TabNew", {
    callback = function()
      local new_tab = vim.fn.tabpagenr()
      M.tab_buffers[new_tab] = {}
    end,
  })

  -- Hide tabline in alpha buffer
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
      vim.opt_local.showtabline = 0
    end,
  })

  -- Restore tabline when leaving alpha buffer
  vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*",
    callback = function()
      if vim.bo.filetype ~= "alpha" then
        vim.opt.showtabline = 2 -- or whatever your default value is
      end
    end,
  })
end

return M

