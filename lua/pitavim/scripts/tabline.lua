local M = {}
local function get_file_icon(filename)
	local file_icon = {
		["lua"] = "󰢱 ",
		["py"] = " ",
		["js"] = " ",
		["ts"] = " ",
		["json"] = " ",
		["cpp"] = " ",
		["yml"] = "",
		["yaml"] = "",
		["toml"] = " ",
		["md"] = " ",
		["txt"] = " ",
		["vim"] = " ",
		["sh"] = " ",
		["bash"] = " ",
		["zsh"] = " ",
		["fish"] = "  ",
		["conf"] = " ",
		["ini"] = "",
		["gitignore"] = " ",
		["gitconfig"] = " ",
	}
	local extension = filename:match("^.+%.(.+)$")
	return file_icon[extension] or ""
end
--
-- function M.MyTabLine()
--   local s = '%#TabLineFill#%{v:lua.require("pitavim.scripts.tabline").ClearHighlight()}'
--   for i = 1, vim.fn.tabpagenr("$") do
--     -- Add a separator before each tab (except the first one)
--     if i > 1 then
--       s = s .. "|%#TabLineFill#|"
--     end
--
--     if i == vim.fn.tabpagenr() then
--       s = s .. "%#TabLineSel#"
--     else
--       s = s .. "%#TabLine#"
--     end
--
--     s = s .. "%" .. i .. "T"
--     s = s .. ' %{v:lua.require("pitavim.scripts.tabline").MyTabLabel(' .. i .. ")} "
--   end
--   s = s .. "%#TabLineFill#%T"
--   return s
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
--   return icon .. " " .. short_name
-- end
--
-- function M.ClearHighlight()
--   vim.cmd("highlight clear TabLineFill")
--   vim.cmd("highlight clear NeoTreeNormal")
--   vim.cmd("highlight clear NeoTreeNormalNC")
--   vim.cmd('lua vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#fabd2f", bg = "NONE" })')
--   return "" -- This function needs to return a string for the tabline
-- end
--
-- function M.setup()
--   vim.o.tabline = [[%!v:lua.require'pitavim.scripts.tabline'.MyTabLine()]]
-- end
--

function M.MyTabLabel(n)
	local buflist = vim.fn.tabpagebuflist(n)
	local winnr = vim.fn.tabpagewinnr(n)
	local bufnr = buflist[winnr]
	local filename = vim.fn.bufname(bufnr)
	local icon = get_file_icon(filename)
	local short_name = vim.fn.fnamemodify(filename, ":t")
	short_name = short_name ~= "" and short_name or "[No Name]"

	return {
		icon = icon,
		text = short_name,
	}
end

function M.MyTabLine()
	local s = '%#TabLineFill#%{v:lua.require("pitavim.scripts.tabline").ClearHighlight()}'
	for i = 1, vim.fn.tabpagenr("$") do
		if i > 1 then
			s = s .. "■%#TabLineFill# ■"
		end

		local is_selected = i == vim.fn.tabpagenr()
		local tab_hl = is_selected and "%#TabLineSel#" or "%#TabLine#"
		local icon_hl = is_selected and "%#TabLineSelIcon#" or "%#TabLineIcon#"

		s = s .. "%" .. i .. "T"

		local label = M.MyTabLabel(i)
		s = s .. tab_hl .. " " .. icon_hl .. label.icon .. tab_hl .. " " .. label.text .. " "
	end
	s = s .. "%#TabLineFill#%T"
	return s
end

function M.ClearHighlight()
	vim.cmd("highlight clear TabLineFill")
	vim.cmd("highlight clear NeoTreeNormal")
	vim.cmd("highlight clear NeoTreeNormalNC")
	vim.cmd('lua vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#fabd2f", bg = "NONE", bold = true })')
	vim.cmd('lua vim.api.nvim_set_hl(0, "TabLine", { fg = "#fbf1c7", bg = "NONE" })')
	vim.cmd('lua vim.api.nvim_set_hl(0, "TabLineIcon", { fg = "#61afef", bg = "NONE" })')
	vim.cmd('lua vim.api.nvim_set_hl(0, "TabLineSelIcon", { fg = "#61afef", bg = "NONE", bold = true })')
	return ""
end

function M.setup()
	vim.o.tabline = [[%!v:lua.require'pitavim.scripts.tabline'.MyTabLine()]]
end

return M
