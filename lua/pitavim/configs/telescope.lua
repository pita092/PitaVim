dofile(vim.g.base46_cache .. "telescope")

local telescope = require("telescope")
local z_utils = require("telescope._extensions.zoxide.utils")
require("telescope").setup({
	title_pos = "center",
	pickers = {
		find_files = {
			prompt_title = "Find Files",
			-- prompt_prefix = " ",
			-- prompt_prefix = "■ ",
		},
		live_grep = {
			prompt_title = "Search Text",
			-- prompt_prefix = "🕵️‍♂️ ",
			-- prompt_prefix = "■ ",

			preview = false,
		},
		current_buffer_fuzzy_find = {
			prompt_title = "Fuzzy Find Current Buffer",
			-- prompt_prefix = " ",
			-- prompt_prefix = "■ ",
		},
		git_files = {
			prompt_title = "Git File",
			-- prompt_prefix = " ",
			-- prompt_prefix = "■ ",
		},
		builtin = {
			prompt_title = "Global Telescope Menu",
			-- prompt_prefix = "  ",
			-- prompt_prefix = "■ ",
		},
		help_tags = {
			prompt_title = "Global Telescope Menu",
			-- prompt_prefix = " ",
			-- prompt_prefix = "■ ",
		},
		git_commits = {
			prompt_title = "Git Commits",
			-- prompt_prefix = " ",
			-- prompt_prefix = "■ ",
		},
		keymaps = {
			prompt_title = "Keymaps",
			-- prompt_prefix = " ",
			-- prompt_prefix = "■ ",
		},
	},
	defaults = {
		-- require("telescope.themes").get_dropdown({
		-- 	previewer = true,
		-- }),
		vimgrep_arguments = {
			"rg",
			"-L",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		previewer = false,
		prompt_prefix = "  ",
		selection_caret = "   ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "bottom",
				preview_width = 0.55,
				results_width = 0.8,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		-- borderchars = { "", "", "", "", "", "", "", "" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" },
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
	},
	extensions = {
		zoxide = {
			prompt_title = "[ Walking on the shoulders of TJ ]",
			mappings = {
				default = {
					after_action = function(selection)
						print("Update to (" .. selection.z_score .. ") " .. selection.path)
					end,
				},
				["<C-s>"] = {
					before_action = function(selection)
						print("before C-s")
					end,
					action = function(selection)
						vim.cmd.edit(selection.path)
					end,
				},
				-- Opens the selected entry in a new split
				["<C-q>"] = { action = z_utils.create_basic_command("split") },
			},
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				winblend = 0,
				width = 0.4,
				prompt_title = "",
				results_title = "",
				previewer = false,
				border = false,
				borderchars = {},
				color_devicons = true,
				prompt_prefix = "",
			}),
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
		media_files = {
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg",
		},
	},
})
telescope.load_extension("themes")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
require("telescope").load_extension("zoxide")
require("telescope").load_extension("gh")

-- defaults = {
--   border = false,
--   previewer = false,
--   layout_strategy = "vertical",
--   layout_config = {
--     width = 0.8,
--     height = 0.8,
--     prompt_position = "top",
--   },
--   prompt_prefix = " 🔭 ",
--   entry_prefix = " ● ",
--   selection_caret = "  ● ",
--   path_display = { "truncate" },
--   file_ignore_patterns = {
--     "dist",
--     "target",
--     "node_modules",
--     "pack/plugins",
--   },
-- },
-- pickers = {
--   find_files = {},
-- },
-- extensions = {
--   ["ui-select"] = {
--     fzf = {
--       fuzzy = true,
--       override_generic_sorter = true,
--       override_file_sorter = true,
--       case_mode = "smart_case",
--     },
--   },
--   media_files = {
--     filetypes = { "png", "webp", "jpg", "jpeg" },
--     find_cmd = "rg",
--   },
-- },
-- cond = function()
--   return vim.fn.executable("make") == 1
-- end,
-- winblend = 30,
