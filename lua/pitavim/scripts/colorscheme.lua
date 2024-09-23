local M = {}

M.save_colorscheme = function(name)
    vim.g.my_colorscheme = name
    vim.cmd("colorscheme " .. name)
    -- Save the colorscheme to a file
    local file = io.open(vim.fn.stdpath("config") .. "/colorscheme.txt", "w")
    if file then
        file:write(name)
        file:close()
    end
end

M.load_colorscheme = function()
    local file = io.open(vim.fn.stdpath("config") .. "/colorscheme.txt", "r")
    if file then
        local name = file:read("*all")
        file:close()
        if name and name ~= "" then
            vim.cmd("colorscheme " .. name)
        end
    end
end

return M

