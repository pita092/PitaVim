local autocmd = vim.api.nvim_create_autocmd

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
      vim.api.nvim_del_augroup_by_name("NvFilePost")

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function()
    vim.opt_local.fillchars:append({ eob = " " })
  end,
})
vim.cmd([[
  autocmd VimEnter * highlight clear TabLineFill
]])

vim.cmd([[
  autocmd VimEnter * highlight clear TabLineSel
]])

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#458588" })
    vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = "#83a598" })
  end,
})

vim.defer_fn(function()
  vim.cmd([[
    highlight SignColumn guibg=NONE ctermbg=NONE
  ]])
end, 100)
