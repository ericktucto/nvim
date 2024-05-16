local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(_, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require("mason").setup({})
require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      local options  = {}
      if server_name == 'volar' then
        options.filetypes = { 'vue', 'typescript', 'javascript' }
      end
      require("lspconfig")[server_name].setup(options)
    end
  }
})
