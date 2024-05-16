local M = {}

function M:all()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  return vim.diagnostic.get(0, { lnum = row - 1 })
end

function M:top()
  local diagnostics = M:all()
  if #diagnostics > 0 then
    local top = diagnostics[1]
    -- find the top diagnostic
    for _, d in ipairs(diagnostics) do
      if d.severity < top.severity then
        top = d
      end
    end
    return top
  else
    return nil
  end
end

return M
