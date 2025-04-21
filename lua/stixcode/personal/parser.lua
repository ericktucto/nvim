local array = require("common.array")
local M = {}

function M.dump(output, indent)
  indent = indent or 1
  local s = ""
  local spaces = string.rep(' ', indent * 2)
  if type(output) == 'table' then
    if array.isArray(output) then
      s = s .. "[\n"
      local count = array.len(output)
      for k, v in pairs(output) do
        local final = ',\n'
        if count == k then
          final = '\n'
        end
        if type(v) == 'table' then
          s = s .. spaces .. M.dump(v, indent + 1)
        else
          s = s .. spaces .. M.ptype(v)
        end
        s = s .. final
      end
      return s .. string.rep(' ', (indent - 1) * 2) .. ']'
    else
      s = s .. "{\n"
      local count = array.len(output)
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
          s = s .. M.dump(v, indent + 1)
        else
          s = s .. M.ptype(v)
        end
        s = s .. final
      end
      return s .. string.rep(' ', (indent - 1) * 2) .. '}'
    end
  end
  return "error: no supported format"
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
    if array.isArray(data) then
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
