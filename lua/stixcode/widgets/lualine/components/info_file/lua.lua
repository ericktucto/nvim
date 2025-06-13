local M = {}

function M:print()
  local ts = vim.treesitter
  local node = ts.get_node()
  if not node then
    return ""
  end

  while node:type() ~= "function_declaration" do
    node = node:parent()
    if not node then
      return ""
    end
  end
  local function_name_node = node:named_child(0)
  if not function_name_node then
    return ""
  end

  return "󰊕 " .. vim.treesitter.get_node_text(function_name_node, 0)
end

return M
