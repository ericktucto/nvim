local map = require("common.mapper").map
local snacks = require("snacks")

snacks.setup({
  picker = {
    enabled = true,
  },
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
