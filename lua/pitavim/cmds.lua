-- local autocmd = vim.api.nvim_create_autocmd
--
-- autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
--   group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
--   callback = function(args)
--     local file = vim.api.nvim_buf_get_name(args.buf)
--     local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
--
--     if not vim.g.ui_entered and args.event == "UIEnter" then
--       vim.g.ui_entered = true
--     end
--
--     if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
--       vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
--       vim.api.nvim_del_augroup_by_name "NvFilePost"
--
--       vim.schedule(function()
--         vim.api.nvim_exec_autocmds("FileType", {})
--
--         if vim.g.editorconfig then
--           require("editorconfig").config(args.buf)
--         end
--       end)
--     end
--   end,
-- })



local autocmd = vim.api.nvim_create_autocmd

-- Existing autocommand for file post-processing
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "NvFilePost"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

-- New autocommand for auto-reloading configuration files
autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("NvConfigReload", { clear = true }),
  pattern = vim.fn.stdpath("config") .. "/lua/custom/*.lua",
  callback = function(args)
    -- Clear the module from package.loaded
    local module_name = args.file:match("lua/custom/(.+).lua$")
    if module_name then
      package.loaded[module_name] = nil
      package.loaded["custom." .. module_name] = nil
    end

    -- Reload the entire custom configuration
    require("plenary.reload").reload_module("custom")

    -- Optionally, you can add specific reload logic for certain modules
    if module_name == "plugins" then
      require("lazy").sync()
    elseif module_name == "mappings" then
      -- Reload mappings
      require("core.utils").load_mappings()
    end

    -- Notify the user
    vim.notify("Configuration reloaded: " .. args.file, vim.log.levels.INFO)

    -- Trigger a custom event that other parts of your config can listen to
    vim.api.nvim_exec_autocmds("User", { pattern = "ConfigReloaded", modeline = false })
  end,
})

