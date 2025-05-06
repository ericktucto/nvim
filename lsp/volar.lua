local settings = require("mason.settings")
local path = settings.current.install_root_dir .. "/packages/vue-language-server/node_modules/typescript/lib"

---@type vim.lsp.Config
return {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = "",
    },
  },
  before_init = function (_, config)
    config.init_options.typescript.tsdk = path
  end
}
