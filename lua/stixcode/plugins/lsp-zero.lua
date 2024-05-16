return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- support to LSP
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- autocomplete
    {
      'hrsh7th/nvim-cmp',
      config = function ()
        local cmp = require('cmp')

        cmp.setup({
          mapping = {
            -- `Enter` key to confirm completion
            ['<CR>'] = cmp.mapping.confirm({select = false}),

            -- Ctrl+Space to trigger completion menu
            ['<C-Space>'] = cmp.mapping.complete(),

            -- Navigation to next suggestion
            ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          }
        })
      end
    },
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},
  },
  config = function()
    local lsp = require('lsp-zero').preset({})

    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({ buffer = bufnr })
    end)

    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
    require('lspconfig').emmet_ls.setup({
      filetypes = {
        "css",
        "ruby",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "svelte",
        "pug",
        "typescriptreact",
        "vue",
        "html.twig.js.css",
      },
    })
    require('lspconfig').pylsp.setup({})
    require('lspconfig').biome.setup({})

    lsp.setup()
  end
}
