local M = {}
function M.get_display_server()
  if vim.fn.getenv("WAYLAND_DISPLAY") ~= vim.NIL then
    return "wayland"
  elseif vim.fn.getenv("DISPLAY") ~= vim.NIL then
    return "x11"
  else
    return "unknown"
  end
end

return M
