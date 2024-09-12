local alpha = require("alpha")
local chafa = require("chafa")

local function display_image()
	local image_path = "/path/to/your/image.png"
	local width = vim.api.nvim_win_get_width(0)
	local height = 20 -- Adjust this value as needed

	return {
		type = "terminal",
		command = function()
			chafa.render(image_path, {
				width = width,
				height = height,
			})
			return ""
		end,
		width = width,
		height = height,
		opts = {
			redraw = true,
			window_config = {},
		},
	}
end

local config = {
	layout = {
		display_image(),
		-- Add other alpha sections here
	},
	opts = {
		margin = 5,
	},
}

alpha.setup(config)
