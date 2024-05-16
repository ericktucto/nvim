return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    theme = "wave",
    background = {
      dark = "dragon",
      light = "wave",
    },
  },
  config = function ()
    vim.cmd.colorscheme("kanagawa")
  end,
}
