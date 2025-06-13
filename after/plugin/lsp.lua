local cmp = require("cmp")
require("codeium").setup()
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "codeium" },
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

    -- Navigation to next suggestion
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })
  }),
})
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("phpactor")
vim.lsp.enable("bashls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("volar")
vim.lsp.enable("emmet_ls")
vim.lsp.enable("somesass_ls")
vim.lsp.enable("solargraph")
vim.lsp.enable("pyright")

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  callback = function ()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end
    vim.diagnostic.open_float({
      scope = "cursor",
      focusable = false,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
    })
  end
})
-- disable diagnostic inline
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
}
