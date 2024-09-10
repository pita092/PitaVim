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

-- Function to capture and notify output
local function capture_and_notify(cmd, opts)
  opts = opts or {}
  local output = vim.api.nvim_exec2(cmd, { output = true }).output
  if output and output ~= "" then
    vim.notify(output, opts.level or "info", { title = opts.title or "Output" })
  end
end

-- Override print function
_G.print = function(...)
  local args = { ... }
  local msg = table.concat(vim.tbl_map(tostring, args), " ")
  vim.notify(msg, "info", { title = "Print" })
end

-- Redirect command output
vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    local cmd = vim.fn.getcmdline()
    if cmd:match("^%s*:") then
      vim.schedule(function()
        capture_and_notify(cmd:sub(2), { title = "Command Output" })
      end)
    end
  end,
})

-- Redirect echo, echomsg, echoerr
local function echo_override(cmd)
  return function(...)
    local args = { ... }
    local msg = table.concat(vim.tbl_map(tostring, args), " ")
    local level = cmd == "echoerr" and "error" or "info"
    vim.notify(msg, level, { title = cmd:upper() })
    -- Still execute the original command for proper Vim behavior
    vim.cmd(string.format("%s %s", cmd, vim.fn.shellescape(msg)))
  end
end

vim.cmd([[
  command! -nargs=+ Echo lua echo_override("echo")(<f-args>)
  command! -nargs=+ Echomsg lua echo_override("echomsg")(<f-args>)
  command! -nargs=+ Echoerr lua echo_override("echoerr")(<f-args>)
]])

-- Override default echo behaviors
vim.cmd([[
  cnoreabbrev <expr> echo (getcmdtype() == ':' && getcmdline() =~ '^echo\s') ? 'Echo' : 'echo'
  cnoreabbrev <expr> echomsg (getcmdtype() == ':' && getcmdline() =~ '^echomsg\s') ? 'Echomsg' : 'echomsg'
  cnoreabbrev <expr> echoerr (getcmdtype() == ':' && getcmdline() =~ '^echoerr\s') ? 'Echoerr' : 'echoerr'
]])

-- Redirect :messages
vim.api.nvim_create_user_command("Messages", function()
  capture_and_notify("messages", { title = "Messages" })
end, {})

-- Optionally, redirect more specific Vim commands as needed
-- Example:
-- vim.api.nvim_create_user_command("Ls", function()
--   capture_and_notify("ls", {title = "Buffer List"})
-- end, {})

-- Set up error handling to use notifications
vim.api.nvim_create_autocmd("VimError", {
  callback = function()
    local error_msg = vim.v.exception
    vim.notify(error_msg, "error", { title = "Vim Error" })
  end,
})
