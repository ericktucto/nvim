local M = require("lualine.component"):extend()
local printers = {
  json = require("stixcode.widgets.lualine.components.info_file.json"),
  lua = require("stixcode.widgets.lualine.components.info_file.lua"),
  php = require("stixcode.widgets.lualine.components.info_file.php"),
}

function M:update_status(_)
  local filetype = vim.bo.filetype
  local printer = printers[filetype]
  if not printer then
    return ""
  end
  return printer:print()
end

return M
