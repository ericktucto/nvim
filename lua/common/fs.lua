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

M.relative_path = function (buffer)
  local workspace = vim.fn.getcwd() .. "/"
  local path_full = vim.api.nvim_buf_get_name(buffer)

  if path_full:sub(1, #workspace) == workspace then
    return path_full:sub(#workspace + 1)
  end

  return nil
end

return M
