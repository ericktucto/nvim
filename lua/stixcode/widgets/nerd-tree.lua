local mapper = require("common.mapper").map
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    relativenumber = true,
    number = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
local bindings = {
  { '<C-x>', ':NvimTreeToggle<CR>', desc = "Alternar explorador de archivos" },
  { "<leader>n", ":NvimTreeFindFile<cr>", desc = "Revelar en el explorador de archivos" },
}
for _, item in pairs(bindings) do
  local bind = item[1]
  local fn = item[2]
  local mode = item.mode
  if mode == nil then mode = "" end
  mapper(mode, bind, fn)
end
