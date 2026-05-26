local M = {}

local group = vim.api.nvim_create_augroup("UserLspAttachEvents", {
  clear = true,
})

local callbacks = {}

local function ensure_autocmd()
  if M._created then
    return
  end

  M._created = true

  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function (event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if not client then
        return
      end

      local client_callbacks = callbacks[client.name]

      if not client_callbacks then
        return
      end

      for _, callback in ipairs(client_callbacks) do
        callback(client, event.buf, event)
      end
    end,
  })
end

function M.on_attach(client_name, callback)
  ensure_autocmd()

  callbacks[client_name] = callbacks[client_name] or {}

  table.insert(callbacks[client_name], callback)

  -- Si el LSP ya estaba attachado antes de registrar este callback,
  -- lo ejecutamos también para los buffers actuales.
  for _, client in ipairs(vim.lsp.get_clients({ name = client_name })) do
    for bufnr, _ in pairs(client.attached_buffers or {}) do
      callback(client, bufnr, {
        buf = bufnr,
        data = {
          client_id = client.id,
        },
      })
    end
  end
end

return M
