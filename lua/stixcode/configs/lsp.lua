local masonpath = vim.fn.stdpath('data') .. '/mason'
local lsp_zero = require("lsp-zero")

return {
  emmet_ls = {
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
  },
  lua_ls = lsp_zero.nvim_lua_ls(),
  tsserver = {
    init_options = {
      plugins = {
        {
          name = '@vue/typescript-plugin',
          location = masonpath .. '/bin/vue-language-server',
          languages = { 'vue' },
        },
      },
    },
  },
  volar = {
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
  },
}
