local lsp_zero = require("lsp-zero")
local defaultOptions = require("stixcode.configs.lsp")
lsp_zero.on_attach(function(_, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require("mason").setup({})
require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      local options  = {}

      if defaultOptions[server_name] ~= nil then
        options = defaultOptions[server_name]
      end

      require("lspconfig")[server_name].setup(options)
    end
  }
})
