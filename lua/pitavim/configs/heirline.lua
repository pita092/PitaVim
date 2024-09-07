local heirline = require("heirline")

-- Define your statusline components
local StatusLine = {
	-- Mode component
	{
		provider = function()
			return " " .. vim.fn.mode() .. " "
		end,
		hl = { fg = "black", bg = "orange", bold = true },
	},
	-- Filename component
	{
		provider = function()
			return " " .. vim.fn.expand("%:t") .. " "
		end,
		hl = { fg = "white", bg = "darkblue" },
	},
	-- Alignment component to push the rest to the right
	{ provider = "%=" },
	-- Line and column information
	{
		provider = function()
			return " %l:%c "
		end,
		hl = { fg = "white", bg = "darkgray" },
	},
}

-- Set up Heirline
heirline.setup({
	statusline = StatusLine,
})
