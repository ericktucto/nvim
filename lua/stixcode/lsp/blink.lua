require("codeium").setup({
  enable_cmp_source = false,
  virtual_text = {
    enabled = true
  },
  default_filetype_enabled = true,
})

require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ["<CR>"] = { "accept", "fallback" },
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<Tab>"] = { "select_next", "fallback" },
  },
  appearance = {
    nerd_font_variant = 'mono'
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = "rounded",
      },
    },
  },

  signature = {
    enabled = true,
    window = {
      border = "rounded",
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'codeium' },
    providers = {
      codeium = { name = "Codeium", module = "codeium.blink", async = true }, │
    },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning"
  }
})
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- ACTIVATION LSP
vim.lsp.enable("lua_ls")
--if vim.fn.exists(vim.fn.getcwd() .. '/psalm.xml') == 0 then
--  vim.lsp.enable("phpstan")
--end
vim.lsp.enable("phpactor")
vim.lsp.enable("psalm")
vim.lsp.enable("bashls")
--vim.lsp.enable("ts_ls")
vim.lsp.enable({ "vtsls", "vue_ls" })
vim.lsp.enable("emmet_ls")
vim.lsp.enable("somesass_ls")
vim.lsp.enable("solargraph")
vim.lsp.enable("pyright")
vim.lsp.enable("dartls")

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
