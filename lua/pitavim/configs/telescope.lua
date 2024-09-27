dofile(vim.g.base46_cache .. "telescope")

local telescope = require("telescope")
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
				prompt_position = "top",
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
		undo = {
			mappings = {
				i = {
					["<cr>"] = require("telescope-undo.actions").yank_additions,
					["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
					["<C-y>"] = require("telescope-undo.actions").yank_deletions,
					["<C-r>"] = require("telescope-undo.actions").restore,
				},
				n = {
					["y"] = require("telescope-undo.actions").yank_additions,
					["Y"] = require("telescope-undo.actions").yank_deletions,
					["u"] = require("telescope-undo.actions").restore,
				},
			},
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- Custom options for a distinct look
				winblend = 10,
				width = 0.8,
				prompt_title = "",
				results_title = "",
				previewer = false,
				border = false,
				borderchars = {},
				color_devicons = true,
				prompt_prefix = "■ ",
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
require("telescope").load_extension("undo")

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
