return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua",
      "luadoc",
      --[[
      "dockerfile",
      "html",
      "javascript",
      "json",
      "php",
      "phpdoc",
      "python",
      "rust",
      "bash",
      "css",
      "scss",
      "sql",
      "toml",
      "typescript",
      "vue",
      "diff",
      ]]
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
        }
      }
    },
  },
}
