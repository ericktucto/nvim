require("nvim-treesitter.configs").setup({
  modules = {},
  sync_install = false,
  auto_install = false,
  ignore_install = {},
  parser_install_dir = vim.fn.stdpath("data") .. "/treesitter",
  ensure_installed = {
    "lua",
    "luadoc",
    "json",
    "php",
    "vue",
    "javascript",
    "html",
  },
})
