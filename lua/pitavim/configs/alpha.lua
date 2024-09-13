local header = {
  [[]],
}

local make_header = function()
  local lines = {}
  for i, line_chars in pairs(header) do
    local hi = i > 15 and "Bulbasaur" .. (i - 15) or "PokemonLogo" .. i
    local line = {
      type = "text",
      val = line_chars,
      opts = {
        hl = "AlphaSpecialKey" .. i,
        shrink_margin = false,
        position = "center",
      },
    }
    table.insert(lines, line)
  end

  local output = {
    type = "group",
    val = lines,
    opts = { position = "center" },
  }

  return output
end

local margin_fix = vim.fn.floor(vim.fn.winwidth(0) / 2 - 46 / 2)

local button = function(sc, txt, keybind, padding)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
  local text = padding and (" "):rep(padding) .. txt or txt

  local offset = padding and padding + 3 or 3

  local opts = {
    width = 46,
    shortcut = sc,
    cursor = -1,
    align_shortcut = "right",
    hl_shortcut = "AlphaButtonShortcut",
    hl = {
      { "AlphaButtonIcon", 0, margin_fix + offset },
      {
        "AlphaButton",
        offset,
        #text,
      },
    },
  }

  if keybind then
    opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = "button",
    val = text,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local thingy = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
thingy:close()

local heading = {
  type = "text",
  opts = {
    position = "center",
    hl = "Folded",
  },
}

local alpha = require("alpha")
require("alpha.term")

local terminal = {
  type = "terminal",
  command = vim.fn.expand("$HOME") .. "/.config/nvim/thisisfine.sh",
  width = 46,
  height = 25,
  opts = {
    redraw = true,
    window_config = {},
  },
}

local section = {
  header = make_header(),
  heading = heading,
  terminal = terminal,
  buttons = {
    type = "group",
    val = {},
    opts = {
      spacing = 1,
    },
  },
}

local marginTopPercent = 0.225
local headerPadding = vim.fn.max({ 4, vim.fn.floor(vim.fn.winheight(0) * marginTopPercent) })

local padding = function(value)
  return { type = "padding", val = value }
end

local config = {
  layout = {
    padding(headerPadding),
    section.terminal,
  },
  opts = {
    margin = margin_fix,
  },
}

alpha.setup(config)

-- vim.api.nvim_create_autocmd(
--   "WinResized",
--   {
--     group = "alpha",
--     callback = function()
--       alpha.redraw()
--     end
--   }
-- )

-- disable statusline in dashboard
vim.api.nvim_create_autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    local old_laststatus = vim.opt.laststatus

    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      callback = function()
        -- vim.opt.laststatus = old_laststatus
      end,
    })

    vim.opt.laststatus = 0
  end,
})
