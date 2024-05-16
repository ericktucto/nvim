vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    exclude = {
      filetypes = {
        "dashboard",
        "lspinfo",
        "mason",
        "lazy",
        -- "NvimTree",
      },
    },
    --[=[
    show_current_context = true,
    show_current_context_start = true,
    buftype_exclude = {
      "terminal"
    },
    filetype_exclude = {
      "dashboard",
      "lspinfo",
      "mason",
      "lazy",
      "NvimTree",
    },
    space_char_blankline = " ",
    char_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
      "IndentBlanklineIndent6",
    },
    ]=]
  },
}

