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
