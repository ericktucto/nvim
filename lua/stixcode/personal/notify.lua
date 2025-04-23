local sys = require("common.system")
local M = {}

function M.simple(message)
  if sys.get_display_server() == "unknown" then
    local notify = require("notify").instance({
      timeout = 120,
      render = "minimal",
    })
    notify(message, "info")
    return true
  end
  io.popen("notify-send -i dialog-information '" .. message .. "'")
  return true
end

return M
