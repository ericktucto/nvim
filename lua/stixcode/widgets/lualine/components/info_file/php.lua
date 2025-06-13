local M = {}

---@param node TSNode
---@return boolean
local function isMethodDeclarationOrFunctionDeclaration(node)
  return node:type() == "method_declaration" or node:type() == "function_definition"
end

function M:print()
  local ts = vim.treesitter
  local node = ts.get_node()
  if not node then
    return ""
  end

  while not isMethodDeclarationOrFunctionDeclaration(node) do
    node = node:parent()
    if not node then
      return ""
    end
  end
  local function_name_node = node:field("name")
  if not function_name_node then
    return ""
  end
  if not function_name_node[1] then
    return ""
  end

  return vim.treesitter.get_node_text(function_name_node[1], 0)
end

return M
