local notify = require("notify")

-- Set up nvim-notify
notify.setup({
	-- Customize as needed
	background_colour = "#000000",
	timeout = 3000,
	max_width = 50,
	max_height = 5,
	stages = "fade_in_slide_out",
})

-- Override vim.notify to use nvim-notify
vim.notify = notify

-- Utility functions
local function notify_output(command, opts)
	local output = vim.api.nvim_exec(command, true)
	if output and output ~= "" then
		vim.notify(output, "info", opts)
	end
end

-- Redirect common commands to use nvim-notify
vim.api.nvim_create_user_command("Messages", function()
	notify_output("messages", { title = "Messages" })
end, {})

-- Redirect echom and echomsg
local echo_notify = function(msg, hl, history)
	vim.notify(msg, "info", { title = "Echo" })
	if history then
		vim.api.nvim_exec("echomsg '" .. msg:gsub("'", "''") .. "'", false)
	end
end

vim.api.nvim_exec(
	[[
  function! EchoNotify(msg, hl, history)
    lua echo_notify(vim.fn.escape(vim.fn.eval("a:msg"), "'"), vim.fn.eval("a:hl"), vim.fn.eval("a:history"))
  endfunction
  command! -nargs=+ -complete=command Echom call EchoNotify(<q-args>, "Echo", 1)
]],
	false
)

-- Override print function
_G.print = function(...)
	local print_safe_args = {}
	for i = 1, select("#", ...) do
		local arg = select(i, ...)
		if type(arg) == "string" then
			table.insert(print_safe_args, arg)
		else
			table.insert(print_safe_args, vim.inspect(arg))
		end
	end
	vim.notify(table.concat(print_safe_args, " "), "info", { title = "Print" })
end

-- Optionally, redirect more Vim commands
vim.cmd([[
  command! -nargs=+ -complete=command Echo call EchoNotify(<q-args>, "Echo", 0)
  command! -nargs=+ -complete=command Echoerr lua vim.notify(<q-args>, "error", {title = "Echoerr"})
]])
