local api = require("lsp-progress.api")
require("lsp-progress").setup(
  require("lsp-progress.defaults").setup({
    format = function (client_messages)
      if #client_messages > 0 then
        return " " .. table.concat(client_messages, " ")
      end
      if #api.lsp_clients() > 0 then
        local clients = vim.lsp.get_clients({
          bufnr = vim.api.nvim_get_current_buf(),
        })
        local names = {}
        for _, client in ipairs(clients) do
          if client.name == "null-ls" then
            return ""
          end
          table.insert(names, client.name)
        end
        if vim.tbl_count(names) > 0 then
          return " " .. table.concat(names, ", ")
        end
      end
      return ""
    end,
  })
)

return {
  x = {
    --[[
    {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn', 'info', 'hint' },
      diagnostics_color = {
        -- Same values as the general color option can be used here.
        error = 'DiagnosticError', -- Changes diagnostics' error color.
        warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
        info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
        hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
      },
      symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
      update_in_insert = false, -- Update diagnostics in insert mode.
      always_visible = false,   -- Show diagnostics even if there are none.
      colored = true,
    },
    ]]
    function ()
      --local result = { "%#lualine_x_diagnostics_error#Hola erick", "%#lualine_x_diagnostics_info#Como estas ?" }
      --return table.concat(result, ' ')
      return ""
    end,
    function ()
      return require("lsp-progress").progress()
    end
  },
  y = {
    {
      'diff',
    },
    function ()
      return require("battery").get_status_line()
    end,
  },
  z = { 'branch' }
}
