local M = {}

local ERROR_NO_JSON = "Error (@runtask/no-json): this string is not a valid JSON"

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

---@return string
local function _dump(output, indent)
  indent = indent or 1
  local s = ""
  local spaces = string.rep(' ', indent * 2)
  if type(output) == 'table' then
    if M.isArray(output) then
      s = s .. "[\n"
      local count = M.len(output)
      for k, v in pairs(output) do
        local final = ',\n'
        if count == k then
          final = '\n'
        end
        if type(v) == 'table' then
          s = s .. spaces .. _dump(v, indent + 1)
        else
          s = s .. spaces .. M.ptype(v)
        end
        s = s .. final
      end
      return s .. string.rep(' ', (indent - 1) * 2) .. ']'
    else
      s = s .. "{\n"
      local count = M.len(output)
      local i = 0
      for k, _ in pairs(output) do
        i = i + 1
        local v = output[k]
        local final = ',\n'
        if i == count then
          final = '\n'
        end
        s = s .. spaces .. "\"" .. k .. "\": "
        if type(v) == "table" then
          s = s .. _dump(v, indent + 1)
        else
          s = s .. M.ptype(v)
        end
        s = s .. final
      end
      return s .. string.rep(' ', (indent - 1) * 2) .. '}'
    end
  end
  return ERROR_NO_JSON
end

---@param json string
function M.split(json)
  local lines = {}
  for s in json:gmatch("[^\r\n]+") do
    table.insert(lines, s)
  end
  return lines
end

---@retun string[]
function M.dump(output, indent)
  local result = _dump(output, indent)
  if result == ERROR_NO_JSON then
    return { result }
  end
  return M.split(result)
end

function M.ptype(data)
  -- when data is string
  if type(data) == "string" then
    return '"' .. data .. '"'
  end
  -- when data is vim.NIL return null
  if data == vim.NIL then
    return "null"
  end
  -- when data is number
  if type(data) == "number" then
    return data
  end
  if type(data) == "table" then
    if M.isArray(data) then
      return "["
    end
    return "{"
  end
  if type(data) == "boolean" then
    if data == true then
      return "true"
    end
    return "false"
  end
  return type(data)
end

return M
