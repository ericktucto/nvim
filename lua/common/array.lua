local M = {}

M.isArray = function (t)
  if type(t) ~= "table" then return false end
  local n = 0
  for k, _ in pairs(t) do
    if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
      return false
    end
    n = n + 1
  end
  return n == #t
end

M.len = function (t)
  local n = 0
  for _ in pairs(t) do
    n = n + 1
  end
  return n
end

return M
