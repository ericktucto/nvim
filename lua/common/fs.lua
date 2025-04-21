local M = {}

M.exists = function (path)
  local f = io.open(path, "r")
  if f ~= nil then
    io.close(f)
    return true
  end
  return false
end
M.read = function (path)
  local f = io.open(path, "r")
  if f ~= nil then
    local content = f:read("*a")
    io.close(f)
    return content
  end
  return nil
end

return M
