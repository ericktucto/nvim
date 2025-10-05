local cmp = require("cmp")
require("codeium").setup()
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "codeium" },
    { name = 'cmp_ai' },
  },
  formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = {
        --path = "[Path]",
        --buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        codeium = "[Codeium]",
        luasnip = "[Snippet]",
        cmp_ai = "[AI]",
      },
    }),
  },
  snippet = {
    expand = function (args)
      vim.snippet.expand(args.body)
    end
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

    ['<C-g>'] = cmp.mapping(
      cmp.mapping.complete({
        config = {
          sources = cmp.config.sources({
            { name = 'cmp_ai' },
          })
        }
      }),
      { 'i' }
    ),

    -- Navigation to next suggestion
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  }),
})
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("phpactor")
vim.lsp.enable("bashls")
--vim.lsp.enable("ts_ls")
vim.lsp.enable({ "vtsls", "vue_ls" })
vim.lsp.enable("emmet_ls")
vim.lsp.enable("somesass_ls")
vim.lsp.enable("solargraph")
vim.lsp.enable("pyright")

-- COMANDS TO LSP
vim.api.nvim_create_user_command('LspLog', function ()
  local p = vim.lsp.get_log_path()
  vim.cmd('tabnew ' .. p)
end, { desc = "Open LSP log file" })

-- RESTART NATIVE LSP
vim.api.nvim_create_user_command('LspRestart', function ()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = bufnr }), true)
  vim.cmd.write()  -- guarda buffers con cambios pendientes
  vim.defer_fn(function ()
    vim.cmd.edit() -- recarga el buffer para reactivar LSP
  end, 500)
end, { desc = "Restart LSP clients on current buffer" })

vim.api.nvim_create_user_command('LspInfo', function ()
  vim.cmd('checkhealth vim.lsp')
end, { desc = "Show LSP health info (alias for :checkhealth vim.lsp)" })

-- LIST ACTIVED CLIENT LSP
vim.api.nvim_create_user_command('LspList', function ()
  local clients = vim.lsp.get_clients()
  if vim.tbl_isempty(clients) then
    print("🔍 LSP Info: No active language servers")
    return
  end
  print("🔍 LSP Info: Active language servers:")
  for _, client in ipairs(clients) do
    print(string.format(" • %s (id=%d)", client.name, client.id))
  end
end, { desc = "Show active LSP clients" })
