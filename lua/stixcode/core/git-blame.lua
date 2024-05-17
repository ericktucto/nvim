local mapper = require("common.mapper").map

require("gitblame").setup({
  enabled = false
})
local bindings = {
  { "<Leader>b", ":GitBlameToggle<CR>", desc = "Toggle show git blame" }
}

for _, item in pairs(bindings) do
  local bind = item[1]
  local fn = item[2]
  local mode = item.mode
  if mode == nil then mode = "" end
  mapper(mode, bind, fn)
end
