local notify = require("notify").instance({
  timeout = 120,
  render = "minimal",
})
local M = {}

function M.simple(message)
  if vim.g.display_server == "unknown" then
    notify(message, "info")
    return true
  end
  io.popen("notify-send -i dialog-information '" .. message .. "'")
  return true
end

return M
