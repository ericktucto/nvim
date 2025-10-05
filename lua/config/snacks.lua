local map = require("common.mapper").map
local snacks = require("snacks")

snacks.setup({
  picker = {
    enabled = true,
  },
  notifier = {
    timeout = 3000, -- default timeout in ms
    width = { min = 40, max = 0.4 },
    height = { min = 1, max = 0.6 },
    -- editor margin to keep free. tabline and statusline are taken into account automatically
    margin = { top = 0, right = 1, bottom = 0 },
    padding = true,            -- add 1 cell of left/right padding to the notification window
    sort = { "level", "added" }, -- sort by level and time
    -- minimum log level to display. TRACE is the lowest
    -- all notifications are stored in history
    level = vim.log.levels.TRACE,
    icons = {
      error = " ",
      warn = " ",
      info = " ",
      debug = " ",
      trace = " ",
    },
    keep = function (notif)
      return vim.fn.getcmdpos() > 0
    end,
    ---@type snacks.notifier.style
    style = "compact",
    top_down = true,  -- place notifications from top to bottom
    date_format = "%R", -- time format for notifications
    -- format for footer when more lines are available
    -- `%d` is replaced with the number of lines.
    -- only works for styles with a border
    ---@type string|boolean
    more_format = " ↓ %d lines ",
    refresh = 50, -- refresh at most every 50ms
  }
})
local keys = {
  { "<leader>sf", function () snacks.picker.grep() end,                  desc = "Search files" },
  { "<leader>gd", function () snacks.picker.git_diff() end,              desc = "Git Diff (Hunks)" },
  { "gd",         function () snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
  { "gD",         function () snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
  { "gr",         function () snacks.picker.lsp_references() end,        nowait = true,                  desc = "References" },
  { "gI",         function () snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
  { "gy",         function () snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
  { "<leader>ss", function () snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
  { "<leader>sS", function () snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
}
for _, key in ipairs(keys) do
  map("n", key[1], key[2], key["desc"])
end
