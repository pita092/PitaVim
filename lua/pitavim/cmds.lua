local autocmd = vim.api.nvim_create_autocmd

autocmd({ "UIEnter", "ColorScheme" }, {
	callback = function()
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		if not normal.bg then
			return
		end
		io.write(string.format("\027]11;#%06x\027\\", normal.bg))
	end,
})

vim.api.nvim_create_autocmd("UILeave", {
	callback = function()
		io.write("\027]111\027\\")
	end,
})

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

vim.cmd([[
  colorscheme gruvbox
  highlight Normal guibg=#282828
  ]])

vim.cmd([[
  colorscheme gruvbox
  highlight TelescopeNormal guibg=#3c3836
  highlight TelescopeSelection guibg=#7c6f64
  highlight  TelescopePromptPrefix guifg=#fabd2f
  ]])

---custom commands

vim.api.nvim_create_user_command("Updt", "Lazy update nvim-plugins", {
	desc = "Update neovim plugins",
})
vim.cmd([[
  function! LuaAbbreviation()
    let cmd = getcmdline()
    if cmd =~ '\v\C^(lua\s+)@!'
      return 'lua'
    endif
    return '🌙'
  endfunction

  cabbrev <expr> lua LuaAbbreviation()
]])
