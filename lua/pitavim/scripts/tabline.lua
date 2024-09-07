-- local M = {}
-- local function get_file_icon(filename)
-- 	local file_icon = {
-- 		["lua"] = "󰢱 ",
-- 		["py"] = " ",
-- 		["js"] = " ",
-- 		["ts"] = " ",
-- 		["json"] = " ",
-- 		["cpp"] = " ",
-- 		["yml"] = "",
-- 		["yaml"] = "",
-- 		["toml"] = " ",
-- 		["md"] = " ",
-- 		["txt"] = " ",
-- 		["vim"] = " ",
-- 		["sh"] = " ",
-- 		["bash"] = " ",
-- 		["zsh"] = " ",
-- 		["fish"] = "  ",
-- 		["conf"] = " ",
-- 		["ini"] = "",
-- 		["gitignore"] = " ",
-- 		["gitconfig"] = " ",
-- 	}
-- 	local extension = filename:match("^.+%.(.+)$")
-- 	return file_icon[extension] or ""
-- end
--
-- function M.MyTabLine()
-- 	local s = '%#TabLineFill#%{v:lua.require("pitavim.scripts.tabline").ClearHighlight()}'
-- 	for i = 1, vim.fn.tabpagenr("$") do
-- 		-- Add a separator before each tab (except the first one)
-- 		if i > 1 then
-- 			s = s .. "|%#TabLineFill#|"
-- 		end
--
-- 		if i == vim.fn.tabpagenr() then
-- 			s = s .. "%#TabLineSel#"
-- 		else
-- 			s = s .. "%#TabLine#"
-- 		end
--
-- 		s = s .. "%" .. i .. "T"
-- 		s = s .. ' %{v:lua.require("pitavim.scripts.tabline").MyTabLabel(' .. i .. ")} "
-- 	end
-- 	s = s .. "%#TabLineFill#%T"
-- 	return s
-- end
--
-- function M.MyTabLabel(n)
-- 	local buflist = vim.fn.tabpagebuflist(n)
-- 	local winnr = vim.fn.tabpagewinnr(n)
-- 	local bufnr = buflist[winnr]
-- 	local filename = vim.fn.bufname(bufnr)
-- 	local icon = get_file_icon(filename)
-- 	local short_name = vim.fn.fnamemodify(filename, ":t")
-- 	short_name = short_name ~= "" and short_name or "[No Name]"
-- 	return icon .. " " .. short_name
-- end
--
-- function M.ClearHighlight()
-- 	vim.cmd("highlight clear TabLineFill")
-- 	vim.cmd("highlight clear NeoTreeNormal")
-- 	vim.cmd("highlight clear NeoTreeNormalNC")
-- 	vim.cmd('lua vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#fabd2f", bg = "NONE" })')
-- 	return "" -- This function needs to return a string for the tabline
-- end
--
-- function M.setup()
-- 	vim.o.tabline = [[%!v:lua.require'pitavim.scripts.tabline'.MyTabLine()]]
-- end
--
-- return M


local M = {}

local function get_file_icon(filename)
    local file_icon = {
        ["lua"] = "󰢱 ",
        ["py"] = " ",
        ["js"] = " ",
        ["ts"] = " ",
        ["json"] = " ",
        ["cpp"] = " ",
        ["yml"] = "",
        ["yaml"] = "",
        ["toml"] = " ",
        ["md"] = " ",
        ["txt"] = " ",
        ["vim"] = " ",
        ["sh"] = " ",
        ["bash"] = " ",
        ["zsh"] = " ",
        ["fish"] = "  ",
        ["conf"] = " ",
        ["ini"] = "",
        ["gitignore"] = " ",
        ["gitconfig"] = " ",
    }
    local extension = filename:match("^.+%.(.+)$")
    return file_icon[extension] or ""
end

local function rainbow_text(text)
    local colors = {"#fb4934", "#fabd2f", "#b8bb26", "#83a598", "#d3839b", "#fb4934"}
    local result = ""
    for i = 1, #text do
        local color = colors[(i-1) % #colors + 1]
        result = result .. "%#TabLineRainbow" .. i .. "#" .. text:sub(i,i)
    end
    return result
end

function M.MyTabLine()
    local s = '%#TabLineFill#%{v:lua.require("pitavim.scripts.tabline").ClearHighlight()}'
    for i = 1, vim.fn.tabpagenr("$") do
        if i > 1 then
            s = s .. "|%#TabLineFill#|"
        end

        if i == vim.fn.tabpagenr() then
            s = s .. "%#TabLineSel#"
        else
            s = s .. "%#TabLine#"
        end

        s = s .. "%" .. i .. "T"
        s = s .. ' %{v:lua.require("pitavim.scripts.tabline").MyTabLabel(' .. i .. ")} "
    end
    s = s .. "%#TabLineFill#%T"
    return s
end

function M.MyTabLabel(n)
    local buflist = vim.fn.tabpagebuflist(n)
    local winnr = vim.fn.tabpagewinnr(n)
    local bufnr = buflist[winnr]
    local filename = vim.fn.bufname(bufnr)
    local icon = get_file_icon(filename)
    local short_name = vim.fn.fnamemodify(filename, ":t")
    short_name = short_name ~= "" and short_name or "[No Name]"
    
    if n == vim.fn.tabpagenr() then
        return icon .. " " .. rainbow_text(short_name)
    else
        return icon .. " " .. short_name
    end
end

function M.ClearHighlight()
    vim.cmd("highlight clear TabLineFill")
    vim.cmd("highlight clear NeoTreeNormal")
    vim.cmd("highlight clear NeoTreeNormalNC")
    
    local colors = {"#fb4934", "#fabd2f", "#b8bb26", "#83a598", "#d3839b", "#fb4934"}
    for i, color in ipairs(colors) do
        vim.cmd(string.format('highlight TabLineRainbow%d guifg=%s guibg=NONE', i, color))
    end
    
    vim.cmd('highlight TabLine guifg=#928374 guibg=NONE')
    vim.cmd('highlight TabLineSel guifg=#fabd2f guibg=NONE')
    
    return ""
end

function M.setup()
    vim.o.tabline = [[%!v:lua.require'pitavim.scripts.tabline'.MyTabLine()]]
end

return M

