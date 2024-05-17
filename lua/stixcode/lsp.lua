local lsp_zero = require("lsp-zero")
local cmp = require("cmp")
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
require("codeium").setup()
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip", keyword_length = 2 },
    { name = "codeium" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    -- confirm completion item
    ['<Enter>'] = cmp.mapping.confirm({ select = true }),

    -- trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})
