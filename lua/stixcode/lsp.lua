local lsp_zero = require("lsp-zero")
local cmp = require("cmp")
local defaultOptions = require("stixcode.configs.lsp")
lsp_zero.on_attach(function (_, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)
require("lspconfig").phpactor.setup({})
require("lspconfig").bashls.setup({})

require("mason").setup({})
require("mason-lspconfig").setup({
  handlers = {
    function (server_name)
      local options = {}

      if defaultOptions[server_name] ~= nil then
        options = defaultOptions[server_name]
      end

      --[[
      if server_name == "phpactor" then
        -- CONFIG PHPCS
        local phpcs_rules = vim.fn.stdpath("config") .. "/lib/phpcs/phpcs.xml"
        local phpcs_path = vim.fn.stdpath("config") .. "/lib/phpcs/vendor/bin/phpcs"
        --phpcs.args = { "-q", "--standard=" .. phpcs_rules, "--report=json", "-" }
        options = {
          init_options = {
            ["php_code_sniffer.enabled"] = true,
            ["php_code_sniffer.bin"] = phpcs_path,
            ["php_code_sniffer.args"] = { "--standard=" .. phpcs_rules },
          }
        }
      end
      ]]

      require("lspconfig")[server_name].setup(options)
    end
  }
})
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
