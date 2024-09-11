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
-- return M
--

local M = {}
local web_devicons = require("nvim-web-devicons")

local function get_file_icon(filename)
	local extension = filename:match("^.+%.(.+)$")
	local icon, icon_color = web_devicons.get_icon(filename, extension)
	return icon or "", icon_color
end

local function get_lsp_diagnostics(bufnr)
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

function M.MyTabLabel(n)
	local buflist = vim.fn.tabpagebuflist(n)
	local winnr = vim.fn.tabpagewinnr(n)
	local bufnr = buflist[winnr]
	local filename = vim.fn.bufname(bufnr)
	local icon, icon_color = get_file_icon(filename)
	local short_name = vim.fn.fnamemodify(filename, ":t")
	short_name = short_name ~= "" and short_name or "[No Name]"

	local diagnostics = get_lsp_diagnostics(bufnr)

	return {
		icon = icon,
		icon_color = icon_color,
		text = short_name,
		warnings = diagnostics.warnings,
		errors = diagnostics.errors,
		info = diagnostics.info,
		hints = diagnostics.hints,
	}
end

function M.MyTabLine()
	local s = '%#TabLineFill#%{v:lua.require("pitavim.scripts.tabline").ClearHighlight()}'
	for i = 1, vim.fn.tabpagenr("$") do
		local is_selected = i == vim.fn.tabpagenr()
		local tab_hl = is_selected and "%#TabLineSel#" or "%#TabLine#"

		s = s .. "%" .. i .. "T"

		local label = M.MyTabLabel(i)
		local icon_hl_name = "TabLineIcon" .. i
		local icon_hl = "%#" .. icon_hl_name .. "#"

		-- Create a custom highlight group for this icon
		vim.cmd(
			string.format(
				"highlight %s guifg=%s guibg=%s",
				icon_hl_name,
				label.icon_color or "#ffffff",
				is_selected and "#504945" or "#3c3836"
			)
		)

		-- Add icon with custom highlight
		s = s .. icon_hl .. label.icon .. " " .. tab_hl .. label.text

		-- Add LSP diagnostic icons with numbers
		if label.errors > 0 then
			s = s .. " %#ErrorMsg#" .. " " .. label.errors
		end
		if label.warnings > 0 then
			s = s .. " %#WarningMsg#" .. " " .. label.warnings
		end
		if label.info > 0 then
			s = s .. " %#InfoMsg#" .. " " .. label.info
		end
		if label.hints > 0 then
			s = s .. " %#HintMsg#" .. " " .. label.hints
		end

		s = s .. " "
	end
	s = s .. "%#TabLineFill#%T"
	return s
end

function M.ClearHighlight()
	vim.cmd("highlight clear NeoTreeNormal")
	vim.cmd("highlight clear NeoTreeNormalNC")
	vim.cmd('lua vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#fabd2f", bg = "#3c3836", bold = true })')
	vim.cmd('lua vim.api.nvim_set_hl(0, "TabLine", { fg = "NONE", bg = "#282828" })')
	vim.cmd('lua vim.api.nvim_set_hl(0, "WarningMsg", { fg = "#fabd2f", bg = "#3c3836" })')
	vim.cmd('lua vim.api.nvim_set_hl(0, "ErrorMsg", { fg = "#fb4934", bg = "#3c3836" })')
	vim.cmd('lua vim.api.nvim_set_hl(0, "InfoMsg", { fg = "#83a598", bg = "#3c3836" })')
	vim.cmd('lua vim.api.nvim_set_hl(0, "HintMsg", { fg = "#8ec07c", bg = "#3c3836" })')
	return ""
end

function M.setup()
	vim.o.tabline = [[%!v:lua.require'pitavim.scripts.tabline'.MyTabLine()]]
end

return M
