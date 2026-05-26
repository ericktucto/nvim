require("codeium").setup({
  enable_cmp_source = false,
  virtual_text = {
    enabled = false
  },
  default_filetype_enabled = true,
})

local lspkind = require('lspkind')
local cmp = require('blink.cmp')
cmp.setup({
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
    menu = {
      border = "single",
      draw = {
        cursorline_priority = 1000,
        columns = {
          { "kind_icon", gap = 1 },
          { "label",     gap = 1 },
          { "kind" },
        },
        components = {
          kind_icon = {
            text = function (ctx)
              local icon = lspkind.symbol_map[ctx.kind] or ctx.kind_icon or ""

              if ctx.source_name == "codeium" or ctx.source_name == "Codeium" then
                icon = ""
              end

              if ctx.kind == "Emmet"
                  or ctx.source_name == "emmet"
                  or ctx.source_name == "Emmet"
                  or (
                    ctx.item
                    and ctx.item.client_name == "vue_ls"
                    and ctx.item.detail == "Emmet Abbreviation"
                  )
              then
                icon = ""
              end

              return icon
            end,
            highlight = function (ctx)
              return {
                {
                  group = "BlinkCmpKind" .. ctx.kind,
                  priority = 20000,
                },
              }
            end,
          },
          label = {
            text = function (ctx)
              return ctx.item.label
            end,
            highlight = "BlinkCmpLabel"
          },
          kind = {
            text = function (ctx)
              local kind = ctx.kind or ""

              if ctx.source_name == "codeium" or ctx.source_name == "Codeium" then
                kind = "Codeium"
              end

              return "(" .. kind .. ") " .. ctx.source_name
            end,
            highlight = "BlinkCmpKindText"
          }
        },
      },
    },
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
      codeium = { name = "Codeium", module = "codeium.blink", async = true },
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
--vim.lsp.enable("phpactor")
vim.lsp.enable("phpantom")
vim.lsp.enable("bashls")
--vim.lsp.enable("ts_ls")
vim.lsp.enable({ "vtsls", "vue_ls" })
vim.lsp.enable("emmet_ls")
vim.lsp.enable("somesass_ls")
vim.lsp.enable("solargraph")
vim.lsp.enable("pyright")
vim.lsp.enable("dartls")
require("stixcode.lsp.java")

-- COMANDS TO LSP
vim.api.nvim_create_user_command('LspLog', function ()
  local p = vim.lsp.log.get_filename()
  vim.cmd('tabnew ' .. p)
end, { desc = "Open LSP log file" })

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
