local settings = require("mason.settings")
local path = settings.current.install_root_dir .. "/packages/vue-language-server"
---@type vim.lsp.Config
return {
  init_options = {
    hostInfo = "neovim",
    --[[
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = path, --.. '/node_modules/@vue/language-server',
        languages = { 'vue' },
      },
    },
    ]]
  },
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  single_file_support = true,
}
