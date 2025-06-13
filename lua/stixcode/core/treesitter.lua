require("nvim-treesitter.configs").setup({
  modules = {},
  sync_install = false,
  auto_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    "lua",
    "luadoc",
    "json",
    "php",
    "vue",
    "typescript",
    "javascript",
    "html",
  },
})
