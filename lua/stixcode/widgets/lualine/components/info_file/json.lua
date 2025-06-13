local M = {}

---@param node TSNode
---@return string
local function getText(node)
  if node:type() == "pair" then
    local string_content = node:child(0):child(1)
    if string_content ~= nil then
      return vim.treesitter.get_node_text(string_content, 0)
    end
  end
  if node:type() == "array" then
    return "[]"
  end
  return ""
end

function M:print()
  local ts = vim.treesitter
  local node = ts.get_node()
  if not node then
    return ""
  end

  local treeJson = {}
  while node ~= nil and node:type() ~= "document" do
    local text = getText(node)
    if text ~= "" then
      table.insert(treeJson, 1, text)
    end
    node = node:parent()
  end

  return table.concat(treeJson, "  ")
end

return M
