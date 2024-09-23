local M = {}

local function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

M.colorscheme_file = vim.fn.stdpath("config") .. "/colorscheme.txt"

M.save_colorscheme = function(name)
    vim.g.my_colorscheme = name
    vim.cmd("colorscheme " .. name)
    local file = io.open(M.colorscheme_file, "w")
    if file then
        file:write(name)
        file:close()
    end
end

M.load_colorscheme = function()
    if file_exists(M.colorscheme_file) then
        local file = io.open(M.colorscheme_file, "r")
        if file then
            local name = file:read("*all")
            file:close()
            if name and name ~= "" then
                vim.cmd("colorscheme " .. name)
            end
        end
    else
        print("Colorscheme file does not exist.")
    end
end

M.check_colorscheme_file = function()
    if file_exists(M.colorscheme_file) then
        print("Colorscheme file exists at: " .. M.colorscheme_file)
    else
        print("Colorscheme file does not exist.")
    end
end

return M

